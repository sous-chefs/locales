require 'serverspec'

set :backend, :exec
set :path, '/sbin:/usr/sbin:$PATH'

describe command('locale -a | grep fr_FR.utf8') do
  # installs the expected locale fr_FR.utf8
  its(:stdout) { should match 'fr_FR.utf8' }
end

describe command('locale -a | grep fr_BE.utf8') do
  # installs the expected locale fr_BE.utf8
  its(:stdout) { should match 'fr_BE.utf8' }
end

describe command('locale -a | grep fr_CA.utf8') do
  # installs the expected locale fr_CA.utf8
  its(:stdout) { should match 'fr_CA.utf8' }
end
