class ListsController < ApplicationController

  get '/trips/:id/lists/new' do
    if is_logged_in?
      @trip = Trip.find(params[:id])
      erb :'/lists/new'
    else
      erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
    end
  end

  post '/trips/:id/lists' do
    if params[:title].empty? || params[:content].empty?
      @trip = Trip.find(session[:user_id])
      erb :'/lists/new', locals: {message: "There seems to be an error. Please try again."}
    else
      @trip = Trip.find(params[:id])
      @list = List.new(title: params[:title], content: params[:content])
      @list.save
      @trip.lists << @list
      redirect "/trips/#{@trip.id}"
    end
  end

  get '/trips/:id/lists/:id' do
    if is_logged_in?
      @list = List.find(params[:id])
      erb :'/lists/show'
    else
      erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
    end
  end

  get '/trips/:id/lists/:id/edit' do
    if is_logged_in?
      @list = List.find(params[:id])
      @trip = Trip.find(@list.trip_id)
      if @trip.user_id == session[:user_id]
        erb :'/lists/edit'
      else
        erb :'/trips/show', locals: {message: "Sorry, you do not have permission to edit this list."}
      end
    else
      erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
    end
  end

  patch '/trips/:id/lists/:id' do
    if params[:title].empty? || params[:content].empty?
      @list = List.find(params[:id])
      erb :'/lists/edit', locals: {message: "There seems to be an error. Please try again."}
    else
      @list = List.find(params[:id])
      @list.update(title: params[:title], content: params[:content])
      redirect "trips/#{@list.trip_id}/lists/#{@list.id}"
    end
  end

  delete '/trips/:id/lists/:id/delete' do
    @list = List.find(params[:id])
    @list.delete
    redirect "/trips/#{@list.trip_id}"
  end

end
