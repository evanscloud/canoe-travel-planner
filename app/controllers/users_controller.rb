class UsersController < ApplicationController
  get '/signup' do
    if is_logged_in?
      redirect '/trips'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect '/trips'
    else
      erb :'/users/signup', locals: {message: "There seems to be an error. Please try again."}
    end
  end

  get '/login' do
    if !is_logged_in?
      erb :'/users/login'
    else
      redirect '/trips'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/trips'
    else
      erb :'/users/login', locals: {message: "There seems to be an error. Please try again."}
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      erb :'/index'
    else
      redirect '/trips'
    end
  end

end
