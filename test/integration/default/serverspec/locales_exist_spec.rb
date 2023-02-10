require 'serverspec'

set :backend, :exec
set :path, '/sbin:/usr/sbin:$PATH'

describe command('locale -a | grep en_US.utf8') do
  # installs the default locale en_US.utf8
  its(:stdout) { should match 'en_US.utf8' }
end
