class ApplicationController < Sinatra::Base
  set :erubis, :escape_html => true
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "chinchilla"
  end

  get '/' do
    erb :index
  end

  helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    # Convenience method for manually escaping html
    def html(text)
      Rack::Utils.escape_html(text)
    end

    def link_to(text, href)
      %(<a href="#{href}">#{h(text)}</a>)
    end
  end

end
