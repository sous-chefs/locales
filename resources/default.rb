# frozen_string_literal: true

provides :locales

unified_mode true

default_action :add

property :locales, [String, Array],
         name_property: true,
         coerce: proc { |value| Array(value) },
         description: 'Locale names to generate.'
property :charmap, String,
         default: 'UTF-8',
         description: 'Character map used when generating locale definitions.'
property :default_locale, String,
         description: 'Locale to write as the system default for the :set action.'
property :locale_file, String,
         default: '/etc/locale.gen',
         description: 'Path to the locale-gen configuration file.'
property :packages, Array,
         default: lazy { platform_family?('debian') ? ['locales'] : [] },
         description: 'Packages required to provide locale-gen and locale data.'
property :lc_all, [true, false],
         default: true,
         description: 'Whether to set LC_ALL when configuring the default locale.'

action_class do
  include ChefLocales::Helper
end

action :add do
  new_resource.packages.each do |package_name|
    package package_name
  end

  execute 'locale-gen' do
    action :nothing
  end

  file new_resource.locale_file do
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end

  new_resource.locales.map { |locale| normalize_locale(locale) }.each do |locale|
    next if locale == 'C'

    ruby_block "enable locale #{high_locale(locale)}" do
      block do
        file = Chef::Util::FileEdit.new(new_resource.locale_file)
        file.insert_line_if_no_match(/#{locale_line_regex(locale)}/, locale_definition(locale))
        file.write_file
      end
      not_if "grep -Eq '#{locale_line_regex(locale)}' #{new_resource.locale_file}"
      notifies :run, 'execute[locale-gen]', :immediately
    end
  end
end

action :set do
  locale = new_resource.default_locale || begin
    raise Chef::Exceptions::ValidationFailed, 'Set exactly one locale or provide default_locale' unless new_resource.locales.count == 1

    new_resource.locales.first
  end

  locales "generate #{locale}" do
    locales [locale]
    charmap new_resource.charmap
    locale_file new_resource.locale_file
    packages new_resource.packages
    action :add
  end

  file '/etc/default/locale' do
    owner 'root'
    group 'root'
    mode '0644'
    manage_symlink_source true
    content default_locale_content(normalize_locale(locale))
  end
end
