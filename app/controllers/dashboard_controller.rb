class DashboardController < ApplicationController
  def index
  	if current_user.present?
  		redirect_to orders_path
  	end
  end
end
