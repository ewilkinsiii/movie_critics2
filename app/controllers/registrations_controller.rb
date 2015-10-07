class RegistrationsController < Devise::RegistrationsController
	before_action :set_user, only: [:show]
  #before_action :update_genre, only: [:update]
  
private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :displayed_name, :avatar, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :displayed_name, :avatar, :email, :password, :password_confirmation, :current_password, genre_ids: [])
  end

  def set_user
      @user = User.find(params[:id])
    end
end