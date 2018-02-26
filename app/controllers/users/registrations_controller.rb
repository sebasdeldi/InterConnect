# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    role_id = Role.where(name: params[:role]).first.id
    build_resource(sign_up_params)
    resource.role_id = role_id
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
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
      errors = resource.errors.messages
      render json: {'success': false, 'password_error': errors[:password], 'password_confirmation_error': errors[:password_confirmation],
       'email_error': errors[:email]}
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  before_action :authenticate_user!, :redirect_unless_admin,  only: [:new, :create]
  skip_before_action :require_no_authentication

  private
  def redirect_unless_admin
    unless is_admin?
      flash[:error] = "Only admins can do that"
      redirect_to unauthenticated_root_path
    end
  end

  def sign_up(resource_name, resource)
    # Overriding so there's no loggin after registration
    true
  end
end
