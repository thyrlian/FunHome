require 'sinatra/base'
require 'sinatra/contrib'

require_relative 'routes/init'

module FunHome
  class App < Sinatra::Base
    configure do
      root_dir = File.dirname(__FILE__)
      set :root, root_dir
      set :app_file, File.join(root_dir, File.basename(__FILE__))
      set :views, "#{root_dir}/views"
      set :public_folder, "#{root_dir}/public"
      set :bind, '0.0.0.0'
      register Sinatra::Namespace
    end
  end
end