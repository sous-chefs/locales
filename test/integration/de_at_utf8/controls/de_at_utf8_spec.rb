# frozen_string_literal: true

title 'de_AT locale'

control 'locales-de-at-01' do
  impact 1.0
  title 'Generates de_AT UTF-8'

  describe command('locale -a') do
    its('stdout') { should match(/de_AT\.utf8|de_AT\.utf-8/i) }
  end
end
