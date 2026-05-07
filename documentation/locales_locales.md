# locales

Generates locales and optionally configures the system default locale.

## Actions

| Action | Description |
| ------ | ----------- |
| `:add` | Generates the requested locales. This is the default action. |
| `:set` | Generates and writes the selected default locale to `/etc/default/locale`. |

## Properties

| Property | Type | Default | Description |
| -------- | ---- | ------- | ----------- |
| `locales` | String, Array | resource name | Locale names to generate. |
| `charmap` | String | `'UTF-8'` | Character map used in locale definitions. |
| `default_locale` | String | `nil` | Locale to configure as the system default for `:set`. |
| `locale_file` | String | `'/etc/locale.gen'` | Locale generation configuration file. |
| `packages` | Array | `['locales']` on Debian-family platforms | Packages that provide locale data and `locale-gen`. |
| `lc_all` | true, false | `true` | Whether `:set` writes `LC_ALL`. |

## Examples

### Generate one locale

```ruby
locales 'de_AT' do
  action :add
end
```

### Generate multiple locales

```ruby
locales 'multiple locales' do
  locales %w(fr_FR fr_BE fr_CA)
end
```

### Configure the default locale

```ruby
locales 'en_US' do
  action :set
end
```

### Configure an explicit default from a list

```ruby
locales 'site locales' do
  locales %w(en_US fr_FR)
  default_locale 'en_US'
  action :set
end
```
