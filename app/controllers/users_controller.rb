class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @users = User.order('created_at DESC').paginate(page: params[:page], per_page: 30)
  end

  def show
  	@review = Review.where(user_id: params[:id]).all
    review = Review.find(params[:id])
    score = Review.find_by(:movie_id => params[:id], :user_id => current_user.id)
    p params[:id]
    @critics = User.joins(:reviews).where(:reviews => {:rating=> review.rating, :movie_id => params[:id]})
  end

  def new
    @user = current_user.users.build
  end

 
  def edit
  end

 
  def create
    params[:user][:genre_ids] ||= []
    @user = User.new(account_update_params)
    if @user.save
      if params[:user][:avatar].blank?
        flash[:notice] = "Successfully created user."
        redirect_to @user
      else
        render :action => "crop"
      end
    else
      render :action => 'new'
    end
  end

 
  def update
    @user= User.find(params[:id][:genre_ids])
    if @user.update_attributes(account_update_params)
      if params[:user][:avatar].blank?
        flash[:notice] = "Successfully updated user."
        redirect_to @user
      else
       render :action => "crop"
      end
    else
     render :action => 'edit'
    end
    
    #@user = User.find(params[:id])
    #if @user.update_attributes!(account_update_params)
      #if params[:user][:avatar].blank?
        #format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        #format.json { respond_with_bip(@user) }
      #else
        #render :action => "crop"
      #end
    #else
      #render :action => 'edit'
    #end
  end


  def destroy
    @user= User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def account_update_params
      params.require(:user).permit(:first_name, :last_name, :displayed_name, :avatar, :email, :admin, genre_ids: [])
    end

    def set_user
      @user = User.find(params[:id][:genre_ids])
    end
end