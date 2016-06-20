class UsersController < ApplicationController
  get '/signup' do
    if is_logged_in?
      redirect '/destinations/index'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect '/destinations/index'
    else
      erb :'/users/signup', locals: {message: "Something seems to be wrong/missing. Please try again."}
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/destinations/index'
    else
      erb :'/users/login', locals: {message: "Email or password is incorrect. Please try again."}
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect 'index'
    else
      redirect '/destinations/index'
    end
  end
end
