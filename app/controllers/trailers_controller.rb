class TrailersController < ApplicationController
  before_action :set_trailer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie
  
  
  def index
    @trailers = Trailer.all
  end

  def show
   
  end

  def new
    @trailer = Trailer.new
  end

 
  def edit
  end

 
  def create
    @trailer = Trailer.new(trailer_params)
    @trailer.movie_id =@movie.id

    respond_to do |format|
      if @trailer.save
        format.html { redirect_to @movie, notice: 'Trailer was successfully created.' }
        format.json { render :show, status: :created, location: @trailer }
      else
        format.html { render :new }
        format.json { render json: @trailer.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    respond_to do |format|
      if @trailer.update(cast_params)
        format.html { redirect_to @movie_path, notice: 'Trailer was successfully updated.' }
        format.json { render :show, status: :ok, location: @trailer }
      else
        format.html { render :edit }
        format.json { render json: @cast.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @trailer.destroy
    respond_to do |format|
      format.html { redirect_to casts_url, notice: 'Trailer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_movie
      @movie =Movie.find(params[:movie_id])
    end

    def set_trailer
      @trailer = trailer.find(params[:id])
    end
    
    def find_trailer
      @trailers = Trailer.find(params[:id])
    end

    def trailer_params
      params.require(:trailer).permit(:title, :embed)
    end
end
