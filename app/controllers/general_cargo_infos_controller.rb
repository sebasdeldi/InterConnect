class GeneralCargoInfosController < ApplicationController

	before_action :set_up

  def new
  end

  def create
  end

  private
  	def set_up
  		@general_cargo_info = GeneralCargoInfo.new
  	end
end
