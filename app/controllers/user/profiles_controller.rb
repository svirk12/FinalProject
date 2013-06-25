class User::ProfilesController < User::BaseController
  before_filter :authenticate_user!

  def show
    @user = current_user
  end
  
  def edit_password
    @resource = current_user
  end
  
  def change_password
    @resource = current_user
    is_update = @resource.update_with_password(
      :password => params[:user][:password],
      :password_confirmation => params[:user][:password_confirmation], 
      :current_password => params[:user][:current_password]
    )
    if is_update
      flash[:notice] = "Password updated successfully"
      sign_in @resource, :bypass => true
      redirect_to user_dashboard_index_path
    else
      render "edit_password"
    end
  end

  def edit_username
    @resource = current_user
  end
  
  def change_username
    @resource = current_user
    is_update = @resource.update_without_password(:username => params[:user][:username])
    if is_update && params[:user][:username].present?
      flash[:notice] = "Username updated successfully"
      sign_in @resource, :bypass => true
      redirect_to user_dashboard_index_path
    else
      flash[:error] = "Username can't be blank'"
      render :edit_username
    end
  end
  
  def destroy
    @user = current_user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Your account was successfully deleted.'  }
    end
  end

end
