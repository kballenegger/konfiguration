require 'konfiguration/version'

require 'yaml'

# The configuration system is based on several environment-specfic YAML files,
# in the app's `config` subdirectory.
#
# The directory structure looks like this:
#   config
#     /dev
#       /a-file-here-will-override-the-shared-version.yml
#     /live
#       /the-environment-is-pulled-from-the-kenji-env.yml
#     /shared
#       /a-file-that-is-shared-across-env.yml
#
# Configuration can be fetched like this:
#
#   Konfiguration.foo :bar, :baz
#
# In this case, it will fetch the configuration file `foo.yml`, and drill down
# within that file to the key `bar.baz`.


class Konfiguration
  class << self

    # We use method missing to capture the configuration to fetch.
    #
    def method_missing(method, *args)
      config(method, *args)
    end

    class KonfigurationError < StandardError; end

    private

    def config(f, *path)
      env = ENV['env'] == 'live' ? 'live' : 'dev' # TODO: dirty
      env_file = "#{env}/#{f.to_s}"
      shared_file = "shared/#{f.to_s}"
      path.map!(&:to_s)

      value = Cache[env_file] || Cache[shared_file]
      path.each do |e|
        unless value.is_a?(Hash) && value.key?(e)
          raise KonfigurationError.new 'Cannot find requested configuration path.'
        end
        value = value[e]
      end
      value
    end

    # Preloaded cache, at startup. :)
    Cache = Hash[Dir["#{$app_path}/config/*/*.yml"].map do |f|
      file = /([^\/]+\/[^\/]+)\.yml$/.match(f)[1]
      [file, YAML.load_file("#{$app_path}/config/#{file}.yml")]
    end]
  end
end
