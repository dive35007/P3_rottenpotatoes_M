class MoviesController < ApplicationController

  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  
  
  def index
    
    if params[:sort]
      sort = params[:sort]
    elsif session[:sort]
      flash.keep
      ratings = session[:ratings] 
      sort    = session[:sort]
      redirect_to movies_path(:sort => sort, :ratings => ratings)
    end
      
    case sort
    when 'title'
      ordering,@title_header = {:order => :title}, 'hilite'
      session[:sort] = sort
    when 'release_date'
      ordering,@date_header = {:order => :release_date}, 'hilite'
      session[:sort] = sort
    end
    
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || {}
    
    if @selected_ratings == {} and session[:ratings]
      @selected_ratings = session[:ratings]
    elsif @selected_ratings == {}
      @selected_ratings = Hash[@all_ratings.map {|rating| [rating, rating]}]
    end
    
    session[:ratings] = @selected_ratings
    
    @movies = Movie.find_all_by_rating(@selected_ratings.keys, ordering)
  end

  
  
  def new
    # default: render 'new' template
  end

  
  
  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  
  
  def edit
    @movie = Movie.find params[:id]
  end

  
  
  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  
  
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
