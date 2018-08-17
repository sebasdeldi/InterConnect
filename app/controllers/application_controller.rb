class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :resource_name, :resource, :devise_mapping, :resource_class, :is_admin?, :is_representative?, :is_shipper?,
    :is_agent?, :is_operation_completed?, :is_fcl_exw?, :is_fcl_exw_info_stage_completed?, :is_fcl_exw_info_requested?, :is_fcl_exw_info_confirmed?,
    :is_pricing_representative?, :is_fcl_exw_quotation_confirmed?, :is_fcl_exw_booking_requested?


  def save_nil
  end

  # Roles detection helpers
  def is_admin?
  	current_role == 'admin' ? true : false
  end

  def is_representative?
  	current_role == 'representative' ? true : false
  end

  def is_shipper?
  	current_role == 'shipper' ? true : false
  end

  def is_agent?
  	current_role == 'agent' ? true : false
  end

  def is_pricing_representative?
    current_role == 'pricing_representative' ? true : false
  end



  # Devise helpers
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


  # Operation helpers
  def is_operation_completed?(operation_id)
    GeneralCargoInfo.find_by(operation_id: operation_id).nil? ? false : true
  end

  # FCL-EXW helpers
  def is_fcl_exw_info_stage_completed?(operation_secure_id)
    operation_id = Operation.find_by(secure_id: operation_secure_id).id
    record = FclExwCargoInfoStep.find_by(operation_id: operation_id)
    if record.created_at == record.updated_at
      false
    else
      if (record.contact_email.nil? || record.contact_number.nil? || record.loading_address.nil? || record.loading_date.nil? || record.loading_time.nil? || record.schedule_b_number.nil? || record.pickup_reference.nil? || record.pieces_number.nil?)
        'orange'
      else
        true
      end
    end
  end

  def is_fcl_exw?(operation_id)
    Operation.find(operation_id).modality == 'FCL - EXW' ? true : false
  end

  def is_fcl_exw_info_requested?(operation_id)
    FclExwInfoRequestedStep.find_by(operation_id: operation_id).completed
  end

  def is_fcl_exw_info_confirmed?(operation_id)
    FclExwInfoConfirmedStep.find_by(operation_id: operation_id).completed
  end

  def is_fcl_exw_quotation_confirmed?(operation_id)
    FclExwQuotationConfirmedStep.find_by(operation_id: operation_id).completed
  end

  def is_fcl_exw_booking_requested?(operation_id)
    FclExwRequestBookingStep.find_by(operation_id: operation_id).completed
  end

  # Admin Charts helpers
  def set_date_range_cookies(day, week, month, year)
    if day
      cookies.permanent[:date_range_param] = 'day'
    elsif week
      cookies.permanent[:date_range_param] = 'week'
    elsif month
      cookies.permanent[:date_range_param] = 'month'
    elsif year
      cookies.permanent[:date_range_param] = 'year' 
    else    
      cookies.permanent[:date_range_param] = 'day'
    end
  end


  # Admin Records Lists helpers
  def set_sorting_cookies(oldest, newest, more_progress, less_progress)
    if oldest
      cookies.permanent[:sort_param] = 'oldest'
    elsif newest
      cookies.permanent[:sort_param] = 'newest'
    elsif more_progress
      cookies.permanent[:sort_param] = 'more_progress'
    elsif less_progress
      cookies.permanent[:sort_param] = 'less_progress' 
    else
      cookies.permanent[:sort_param] = 'newest'   
    end
  end

  def set_query_params_cookies(modality, status, search)
    @modality_content = nil
    @status_content = nil
    @search_content = nil
    cookies.permanent[:modality] = modality
    cookies.permanent[:status] = status
    cookies.permanent[:search] = search
  end

  # Tasks cookies settings
  def set_tasks_cookies(today, this_week, this_month, all)
    if today
      cookies.permanent[:date_range_param] = 'today'
    elsif this_week
      cookies.permanent[:date_range_param] = 'this_week'
    elsif this_month
      cookies.permanent[:date_range_param] = 'this_month'
    else
      cookies.permanent[:date_range_param] = 'all'
    end
  end

  private
  	def current_role
  		current_role = current_user.nil? ? 'Not logged in' : Role.find(current_user.role_id).name 
  	end

    def require_new_operation_permission
      check_permission('representative', 'agent')
    end

    def check_permission(*roles)
      unless roles.include? current_role
        flash[:alert] = "Access denied"
        redirect_back(fallback_location: authenticated_root_path)
      end
    end


end
