class DestinationsController < ApplicationController

  get '/destinations' do
    if is_logged_in?
      @destinations = Destination.all
      erb :'/destinations/index'
    else
      erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
    end
  end

  get '/destinations/new' do
    if is_logged_in?
      erb :'/destinations/new'
    else
      erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
    end
  end

  post '/destinations' do
    if params[:name].empty? || params[:location].empty?
      erb :'/destinations/new', locals: {message: "There seems to be an error. Please try again."}
    else
      user = current_user
      @destination = Destination.create(name: params[:name], location: params[:location], user_id: user.id)
      redirect "/destinations/#{@destination.id}"
    end
  end

  get '/destinations/:id' do
    if is_logged_in?
      @destination = Destination.find(params[:id])
      erb :'/destinations/show'
    else
      erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
    end
  end

  get '/destinations/:id/edit' do
    if is_logged_in?
      @destination = Destination.find(params[:id])
      if @destination.user_id == session[:user_id]
        erb :'/destinations/edit'
      else
        erb :'/destinations', locals: {message: "Sorry, you do not have permission to edit this destination."}
      end
    else
      erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
    end
  end

  patch '/destinations/:id' do
    if params[:name].empty? || params[:location].empty?
      @destination = Destination.find(params[:id])
      erb :'/destinations/edit', locals: {message: "There seems to be an error. Please try again."}
    else
      @destination = Destination.find(params[:id])
      @destination.update(name: params[:name], location: params[:location])
      redirect "/destinations/#{@destination.id}"
    end
  end

  delete '/destinations/:id/delete' do
    @destination = Destination.find(params[:id])
    @destination.delete
    redirect '/destinations'
  end

end
