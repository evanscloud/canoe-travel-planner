class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "chinchilla"
  end

  get '/' do
    if is_logged_in?
      erb :'destinations/index'
    else
      erb :index
    end
  end

  helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
