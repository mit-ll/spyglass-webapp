class UsersController < ApplicationController
  load_and_authorize_resource
  def new
    @user = User.new
  end

  def index
    @users = User.order("login ASC").page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @logged_in_user = User.find(current_user.id)

    if @logged_in_user.has_role? :admin
      if params[:roles]
        # calculate mask value
        role_mask_value = 0 
        params[:roles].each do |r| 
          role_mask_value = role_mask_value + User.mask_for(r.to_sym).to_i
        end 
        @user.roles_mask = role_mask_value
      else
        if @logged_in_user != @user
          @user.roles_mask = 1
        end
      end 
    end 

    if @user.update_attributes(user_edit_params)
      flash[:success] = "User settings edited."
      redirect_to user_path
    else
      flash[:danger] = "User setting edit failed."
      redirect_to user_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User Added."
      redirect_to @user
    else
      flash.now[:danger] = "There were errors with your request."
      render 'new'
    end 
  end 

  def destroy
    @user = User.find(params[:id])
    if @user == User.find(current_user.id)
      flash[:danger] = "You can't remove yourself!"
      redirect_to users_path
    else
      @user.destroy
      redirect_to users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:login, :roles, :password, :password_confirmation, :use_yubikey, :registered_yubikey)
  end
  def user_edit_params
    params.require(:user).permit(:roles, :password, :password_confirmation, :use_yubikey, :registered_yubikey)
  end
end
