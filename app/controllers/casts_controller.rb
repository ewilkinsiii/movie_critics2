class CastsController < ApplicationController
  before_action :set_cast, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie
  
  
  def index
    @casts = Cast.all
  end

  def show
   
  end

  def new
    @cast = Cast.new
  end

 
  def edit
  end

 
  def create
    @cast = Cast.new(cast_params)
    @cast.movie_id =@movie.id

    respond_to do |format|
      if @cast.save
        format.html { redirect_to @movie, notice: 'Cast was successfully created.' }
        format.json { render :show, status: :created, location: @cast }
      else
        format.html { render :new }
        format.json { render json: @cast.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    respond_to do |format|
      if @cast.update(cast_params)
        format.html { redirect_to @movie, notice: 'Cast was successfully updated.' }
        format.json { render :show, status: :ok, location: @cast }
      else
        format.html { render :edit }
        format.json { render json: @cast.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @cast.destroy
    respond_to do |format|
      format.html { redirect_to casts_url, notice: 'Cast was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_movie
      @movie =Movie.find(params[:movie_id])
    end

    def set_cast
      @cast = Cast.find(params[:id])
    end
    
    def find_cast
      @casts = Cast.find(params[:id])
    end

    def cast_params
      params.require(:cast).permit(:actor_type, :movie_id, :first_name, :last_name, :characters_name, :image)
    end
end
