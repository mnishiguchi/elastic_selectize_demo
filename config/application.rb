require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ElasticSelectizeDemo
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths << "#{config.root}/app/searches"

    #===> Browserify
    # http://inlehmansterms.net/2016/04/29/modern-javascript-in-rails/
    config.browserify_rails.commandline_options = '-t [ babelify --presets [ es2015 es2016 stage-2 stage-0 ] ]'
    # this will turn on sourcemaps for development RAILS_ENV
    config.browserify_rails.source_map_environments << 'development'
    # this tells browserify what paths/files it needs to be concerned with
    # we will just use node_modules and the browserify folder we just created
    config.browserify_rails.paths = [
      lambda { |p| p.start_with?(Rails.root.join('node_modules').to_s) },
      lambda { |p| p.start_with?(Rails.root.join('app/assets/javascripts/browserify').to_s) },
    ]
  end
end
