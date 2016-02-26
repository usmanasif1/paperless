class ApplicationController < ActionController::Base

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery
  # before_filter :authenticate_user!

  #Custom route for devise, reroutes back to the homepage this is the root_path or root_url
  def after_sign_in_path_for(resource)
    if current_user.present?
      users_path
    else
      root_url
    end
  end

  #Custom route for devise, after registration
  def after_sign_up_path_for(resource)
    users_path
  end

    private

  def user_not_authorized
    flash[:danger] = "Access denied."
    redirect_to (request.referrer || root_url)
  end

end
