# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    #debugger
    sort = params[:sort] || 'id'

    @all_ratings = Movie.all_ratings.keys

    if params.has_key? :ratings
      selected_ratings = params[:ratings].keys
    else
      selected_ratings = @all_ratings
    end

    @title_sort = hiliter('title')
    @rating_sort = hiliter('rating')

    @movies = Movie.order(sort).where(rating: selected_ratings)
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def new
    @movie = Movie.new
  end

  def create
    #@movie = Movie.create!(params[:movie]) #did not work on rails 5.
    @movie = Movie.create(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created!"
    redirect_to movies_path
  end

  def movie_params
    params.require(:movie).permit(:title,:rating,:description,:release_date)
  end

  def edit
    id = params[:id]
    @movie = Movie.find(id)
    #@movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    #@movie.update_attributes!(params[:movie])#did not work on rails 5.
    @movie.update(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated!"
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:notice] = "#{@movie.title} was deleted!"
    redirect_to movies_path
  end

  def hiliter(field)
    if params[:sort].to_s == field
      'hilite'
    else
      "null"
    end
  end

end