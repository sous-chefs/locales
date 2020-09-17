default['locales']['packages'] = if platform_family?('debian')
                                   ['locales']
                                 else
                                   []
                                 end

default['locales']['locale_file'] = if platform?('ubuntu')
                                      '/var/lib/locales/supported.d/local'
                                    else
                                      '/etc/locale.gen'
                                    end

default['locales']['default'] = 'en_US'
