require_relative '../extra/player'

module FunHome
  class App < Sinatra::Base
    register Sinatra::Namespace
    
    namespace '/' do
      get '/?' do
        msg = 'Welcome Home'
        Player.speak(msg, {:language => 'en', :voice => 'Good News'})
        msg
      end
      
      get 'custom/:language/:voice/:text/?' do
        Player.speak(params[:text], {:language => params[:language], :voice => params[:voice]})
      end
    end
  end
end