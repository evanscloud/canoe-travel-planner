class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "chinchilla"
  end

  get '/' do
    erb :index
  end

end
