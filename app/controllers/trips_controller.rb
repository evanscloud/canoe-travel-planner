class TripsController < ApplicationController

  get '/trips' do
    if is_logged_in?
      @trips = Trip.all
      erb :'/trips/index'
    else
      erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
    end
  end

  get '/trips/new' do
    if is_logged_in?
      erb :'/trips/new'
    else
      erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
    end
  end

  post '/trips' do
    if params[:name].empty? || params[:location].empty?
      erb :'/trips/new', locals: {message: "There seems to be an error. Please try again."}
    else
      user = current_user
      @destination = Trip.create(name: params[:name], location: params[:location], user_id: user.id)
      redirect "/trips/#{@destination.id}"
    end
  end

  get '/trips/:id' do
    if is_logged_in?
      @destination = Trip.find(params[:id])
      erb :'/trips/show'
    else
      erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
    end
  end

  get '/trips/:id/edit' do
    if is_logged_in?
      @destination = Trip.find(params[:id])
      if @destination.user_id == session[:user_id]
        erb :'/trips/edit'
      else
        erb :'/trips', locals: {message: "Sorry, you do not have permission to edit this destination."}
      end
    else
      erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
    end
  end

  patch '/trips/:id' do
    if params[:name].empty? || params[:location].empty?
      @destination = Trip.find(params[:id])
      erb :'/trips/edit', locals: {message: "There seems to be an error. Please try again."}
    else
      @destination = Trip.find(params[:id])
      @destination.update(name: params[:name], location: params[:location])
      redirect "/trips/#{@destination.id}"
    end
  end

  delete '/trips/:id/delete' do
    @destination = Trip.find(params[:id])
    @destination.delete
    redirect '/trips'
  end

end
