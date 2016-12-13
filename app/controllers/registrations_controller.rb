class RegistrationsController < Devise::RegistrationsController
	before_action :set_user, only: [:show, :update]
  #before_action :update_genre, only: [:update]

  def create
    params[:movie][:genre_ids] ||= []
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
    @user = User.find params[:id]
    params[:movie][:genre_ids] ||= []
    respond_to do |format|
      if @user.update_attributes!(account_update_params)
        if params[:user][:avatar].blank?
          format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
          format.json { respond_with_bip(@user) }
        else
          render :action => "crop"
          logger.debug "Hello world! #{@user.to_yaml}"
        end
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@user) }
      end
    end
  end

private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :displayed_name, :avatar, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :displayed_name, :avatar, :email, :admin, :password, :password_confirmation, :current_password, genre_ids: [])
  end

  def set_user
      @user = User.find(params[:id])
  end
end