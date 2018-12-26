class UsersController < ApplicationController
  def edit
    @user = User.find params[:id]
    @role = Role.find(@user.role_id).name
  end

  def update
    user = User.find params[:id]
    user.update(user_strong_params)
    flash[:notice] = 'Information Updated'
    redirect_back(fallback_location: authenticated_root_path)
  end

  private
	  def user_strong_params
	    params.require(:user).permit(:company_name, :contact_first_name, :contact_last_name, :phone_number, :address, :state, :country, :city, :account_type, :zip_code,
	    :email, :password, :outlook_password, :documental_email )
	  end
end
