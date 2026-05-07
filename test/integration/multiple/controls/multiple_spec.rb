# frozen_string_literal: true

title 'Multiple locales'

%w(fr_FR fr_BE fr_CA).each do |locale|
  control "locales-#{locale.downcase.tr('_', '-')}-01" do
    impact 1.0
    title "Generates #{locale} UTF-8"

    describe command('locale -a') do
      its('stdout') { should match(/#{locale}\.utf8|#{locale}\.utf-8/i) }
    end
  end
end
