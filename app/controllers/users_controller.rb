class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.order('created_at DESC').paginate(page: params[:page], per_page: 30)
  end

  def show
  	@review = Review.where(user_id: params[:id]).all
    review = Review.find(params[:id])
    score = Review.find(:movie_id => params[:id], :user_id => current_user.id)
    p params[:id]
    @critics = User.joins(:reviews).where(:reviews => {:rating=> review.rating, :movie_id => params[:id]})
  end

  private
    
    def set_user
      @user = User.find(params[:id])
    end
end