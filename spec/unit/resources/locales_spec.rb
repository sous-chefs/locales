# frozen_string_literal: true

require 'spec_helper'

describe 'locales' do
  step_into :locales
  platform 'ubuntu', '24.04'

  context 'with action add' do
    recipe do
      locales 'fr_FR' do
        action :add
      end
    end

    before do
      stub_command("grep -Eq '^fr_FR\\.UTF\\-8[[:space:]]+UTF\\-8$' /etc/locale.gen").and_return(false)
    end

    it { is_expected.to install_package('locales') }
    it { is_expected.to create_file('/etc/locale.gen') }
    it { is_expected.to run_ruby_block('enable locale fr_FR.UTF-8') }
    it { is_expected.to nothing_execute('locale-gen') }
  end

  context 'with action set' do
    recipe do
      locales 'en_US' do
        action :set
      end
    end

    before do
      stub_command("grep -Eq '^en_US\\.UTF\\-8[[:space:]]+UTF\\-8$' /etc/locale.gen").and_return(false)
    end

    it { is_expected.to install_package('locales') }
    it { is_expected.to run_ruby_block('enable locale en_US.UTF-8') }
    it { is_expected.to create_file('/etc/default/locale').with(content: "LANG=en_US.UTF-8\nLANGUAGE=en_US.UTF-8\nLC_ALL=en_US.UTF-8\n") }
  end

  context 'with custom properties' do
    recipe do
      locales 'custom default' do
        locales %w(fr_FR fr_BE)
        default_locale 'fr_BE'
        locale_file '/tmp/locale.gen'
        packages %w(locales custom-locales)
        lc_all false
        action :set
      end
    end

    before do
      stub_command("grep -Eq '^fr_BE\\.UTF\\-8[[:space:]]+UTF\\-8$' /tmp/locale.gen").and_return(false)
    end

    it { is_expected.to install_package('locales') }
    it { is_expected.to install_package('custom-locales') }
    it { is_expected.to create_file('/tmp/locale.gen') }
    it { is_expected.to create_file('/etc/default/locale').with(content: "LANG=fr_BE.UTF-8\nLANGUAGE=fr_BE.UTF-8\n") }
  end
end
