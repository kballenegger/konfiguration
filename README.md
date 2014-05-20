# Konfiguration

Konfiguration makes it easy to load YAML-formatted configuration files.

## Installation

Add this line to your application's Gemfile:

    gem 'konfiguration'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install konfiguration

## Usage

The system looks for two external pieces of information in order to function:

1. `$app_path` must be set to the expanded path of the root of the app.
2. `ENV['env']` is the current environment, e.g., `live`, `dev`, etc. (Defaults
   to `dev`).

The configuration system is based on several environment-specfic YAML files, in
the app's `config` subdirectory.

The directory structure looks like this:

    config
      /dev
        /a-file-here-will-override-the-shared-version.yml
      /live
        /the-environment-is-pulled-from-the-kenji-env.yml
      /shared
        /a-file-that-is-shared-across-env.yml

Configuration can be fetched like this:

    Konfiguration.foo :bar, :baz

In this case, it will fetch the configuration file `foo.yml`, and drill down
within that file to the key `bar.baz`.

## Contributing

1. Fork it ( https://github.com/kballenegger/konfiguration/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
