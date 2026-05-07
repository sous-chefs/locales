# locales limitations

This cookbook manages Debian-style locale generation with the `locales` package, `/etc/locale.gen`,
`locale-gen`, and `/etc/default/locale`.

## Platform support

Supported local test and CI targets:

| Platform | Versions | Notes |
| -------- | -------- | ----- |
| Debian | 12 | Debian 12 remains in support and provides the `locales` package and `locale-gen`. |
| Ubuntu | 22.04, 24.04 | Ubuntu LTS releases provide the `locales` package and `locale-gen`. |

EOL platforms removed from the previous matrix: Debian 9, Debian 10, Ubuntu 18.04, and Ubuntu 20.04.

## Package and source constraints

The cookbook does not compile glibc from source. It installs the configured `packages` property,
defaults to `['locales']` on Debian-family platforms, updates the configured locale generation file,
and runs `locale-gen`.

Debian documents `/etc/locale.gen` as the newline-delimited locale build list consumed by
`locale-gen`. Ubuntu 24.04 publishes the `locales` binary package from glibc with tools to generate
locale definitions from source files.
