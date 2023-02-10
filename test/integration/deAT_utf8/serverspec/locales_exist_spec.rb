require 'serverspec'

set :backend, :exec
set :path, '/sbin:/usr/sbin:$PATH'

describe command('locale -a | grep de_AT.utf8') do
  # installs the expected locale de_AT.utf8
  its(:stdout) { should match 'de_AT.utf8' }
end
