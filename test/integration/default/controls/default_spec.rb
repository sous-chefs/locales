# frozen_string_literal: true

title 'Default locale'

control 'locales-default-01' do
  impact 1.0
  title 'Generates and configures the default locale'

  describe command('locale -a') do
    its('stdout') { should match(/en_US\.utf8|en_US\.utf-8/i) }
  end

  describe file('/etc/default/locale') do
    it { should exist }
    its('content') { should match(/^LANG=en_US\.UTF-8$/) }
    its('content') { should match(/^LANGUAGE=en_US\.UTF-8$/) }
    its('content') { should match(/^LC_ALL=en_US\.UTF-8$/) }
  end
end
