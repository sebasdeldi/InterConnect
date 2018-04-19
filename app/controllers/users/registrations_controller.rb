
class Users::RegistrationsController < Devise::RegistrationsController

  def create
    role = Role.where(name: params[:role]).first
    if params[:password].present?
      user = User.new(user_strong_params.merge(role_id: role.id))
    else
      user = User.new(user_strong_params.merge(role_id: role.id, password: '12345678'))
    end

    user.save

    yield resource if block_given?
    if user.persisted?
      if user.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        #respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        #respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
      render json: {'success': true}
    else
      clean_up_passwords resource
      set_minimum_password_length
      #respond_with resource
      errors = user.errors.messages
      render json: {'role': role.name, 'success': false, 'password_error': errors[:password], 'password_confirmation_error': errors[:password_confirmation],
       'email_error': errors[:email]}
    end
  end



  before_action :authenticate_user!, :redirect_unless_admin,  only: [:new, :create]
  skip_before_action :require_no_authentication

  private

  def user_strong_params
    params.require(:user).permit(:company_name, :contact_first_name, :contact_last_name, :phone_number, :address, :state, :country, :city, :account_type, :zip_code,
    :email, :password, :outlook_password )
  end

  def redirect_unless_admin
    unless is_admin? || is_representative? || is_agent?
      flash[:error] = "Only admins can do that"
      redirect_to unauthenticated_root_path
    end
  end

  def sign_up(resource_name, resource)
    # Overriding so there's no loggin after registration
    true
  end
end
