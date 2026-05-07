# locales migration guide

This release removes the legacy recipe, attribute, and provider APIs. Consumers must declare the
`locales` custom resource directly.

## Removed APIs

The following APIs no longer exist:

* `recipe[locales::default]`
* `recipe[locales::install]`
* `node['locales']['packages']`
* `node['locales']['locale_file']`
* `node['locales']['default']`
* Legacy `resources/default.rb` plus `providers/default.rb` LWRP implementation

## Replacements

Use resource properties instead of node attributes:

```ruby
locales 'en_US' do
  packages ['locales']
  locale_file '/etc/locale.gen'
  action :set
end
```

Generate several locales:

```ruby
locales 'site locales' do
  locales %w(en_US fr_FR fr_BE)
  default_locale 'en_US'
  action :set
end
```

Test cookbook examples live in `test/cookbooks/test/recipes/`.
