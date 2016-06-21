class UsersController < ApplicationController
  get '/signup' do
    if is_logged_in?
      redirect '/destinations'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect '/destinations'
    else
      erb :'/users/signup', locals: {message: "There seems to be an error. Please try again."}
    end
  end

  get '/login' do
    if !is_logged_in?
      erb :'/users/login'
    else
      redirect '/destinations'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/destinations'
    else
      erb :'/users/login', locals: {message: "There seems to be an error. Please try again."}
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect 'index'
    else
      redirect '/destinations'
    end
  end

end
