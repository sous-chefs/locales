default['locales']['packages'] = if platform_family?('debian')
                                   ['locales']
                                 else
                                   []
                                 end

default['locales']['locale_file'] = '/etc/locale.gen'

default['locales']['default'] = 'en_US'
