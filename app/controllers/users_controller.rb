class UsersController < ApplicationController
 before_filter :authenticate_user!

  def index
    authorize current_user
    # if current_user && current_user.roles.where(name: ["User"]).any?
      # redirect_to root_url
    # else
      @users = User.all
    # end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def update
    # authorize! :update, @user, :message => 'Not authorized as an administrator.'
    authorize current_user
    @user = User.find(params[:id])
    # if @user.update_attributes(params[:user], :as => :admin)
    user_role = @user.user_roles.first
    user_role.role_id = params[:user][:role_ids].to_i
    if user_role.save
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize :user
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end