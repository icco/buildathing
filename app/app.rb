module Buildathing
  class App < Padrino::Application
    register ScssInitializer
    use ConnectionPoolManagement
    register Padrino::Helpers

    enable :sessions

    ##
    # Caching support.
    register Padrino::Cache
    enable :caching

    ##
    # Application configuration options.
    set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    set :css_asset_folder, 'css'
    set :js_asset_folder, 'js'
  end
end
