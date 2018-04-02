class UserImportsController < ApplicationController
	before_action :authenticate_user!, :verify_admin

	def new
		@user_import = UserImport.new
	end

  def create
    @user_import = UserImport.new
  	if @user_import.save_imported_users(params[:user_import][:file])
      redirect_to authenticated_root_path, notice: "Imported records successfully."
    else
      render :new
  	end
	end

	private
		def verify_admin
			unless is_admin?
				redirect_to authenticated_root_path
			end
		end
end
