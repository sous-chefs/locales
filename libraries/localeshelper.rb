module ChefLocales
  module Helper
    def current_locale
      cmd = shell_out('locale')
      Hash[cmd.stdout.split.map { |c| c.chomp.gsub('"', '').split('=') }]
    end

    def locales_available
      shell_out('locale -a').stdout.split
    end

    def locale_pattern
      /(C|[a-z]*)(_[A-Z]*)?/
    end
  end
end
