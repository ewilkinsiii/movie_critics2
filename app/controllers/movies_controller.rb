class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]
  
  def search
    if params[:search]
      @movies= Movie.where('title ILIKE ?', "%" + params[:search] + "%")
    #if params[:search].present?
      #@movies = Movie.search(params[:search])
    #elsif params[:category]
     # genre= Genre.find_by(:category => params[:category])
      #@movies = genre.movies
    #else
      #@movies = Movie.all 
    end 
  end
  
  def index
    @movies = Movie.all
    if params[:search]
      @movies= Movie.where('title ILIKE ?', "%" + params[:search] + "%")
    elsif params[:category]
      genre= Genre.find_by(:category => params[:category])
      @movies = genre.movies
    end
  end

  def show
    @trailer =Trailer.where(movie_id: params[:id])
    @cast = Cast.where(movie_id: params[:id]) 
    @reviews =Review.where(movie_id: @movie.id).order("created_at DESC").take(5)
    @review =Review.where(movie_id: @movie.id).order("created_at DESC")

    if @review.blank?
      @avg_review = 0
    else
      @avg_review = @review.average(:rating).round(2)
    end
  end

  def new
    @movie = current_user.movies.build
  end

 
  def edit
  end

 
  def create
    params[:movie][:genre_ids] ||= []
    @movie = current_user.movies.build(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    params[:movie][:genre_ids] ||= []
    respond_to do |format|
      if @movie.update(movie_params) 
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @movie= Movie.find(params[:id])
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :description, :director_first_name, :director_last_name, :imdb_id, :year, :release_date, :mpaa_rating, :run_time, :image, genre_ids: [])
    end
end
