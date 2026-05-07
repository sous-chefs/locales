# frozen_string_literal: true

module ChefLocales
  module Helper
    def normalize_locale(locale)
      parsed_locale(locale)['locale']
    end

    def locale_definition(locale)
      "#{high_locale(locale)} #{new_resource.charmap}"
    end

    def high_locale(locale)
      parsed = parsed_locale(locale)
      return 'C' if parsed['locale'] == 'C'

      "#{parsed['locale']}.#{new_resource.charmap.upcase}"
    end

    def parsed_locale(locale)
      match = /^(?<locale>C|[a-z]{2}_[A-Z]{2}(?:@[[:alnum:]]+)?)\.?(?<charmap>.*)$/.match(locale)
      raise Chef::Exceptions::ValidationFailed, "#{locale} is not a valid locale name" unless match

      Hash[match.names.zip(match.captures)]
    end

    def locale_line_regex(locale)
      "^#{Regexp.escape(high_locale(locale))}[[:space:]]+#{Regexp.escape(new_resource.charmap)}$"
    end

    def default_locale_content(locale)
      variables = %w(LANG LANGUAGE)
      variables << 'LC_ALL' if new_resource.lc_all

      variables.map { |variable| "#{variable}=#{high_locale(locale)}" }.join("\n") << "\n"
    end
  end
end
