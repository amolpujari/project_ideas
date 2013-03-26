class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SimpleCaptcha::ControllerHelpers

  def login_require
    return redirect_to root_url, :alert=>'Login Required' unless current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def set_current_user user
    session[:user_id] = user.id
    @current_user = user
  end
end