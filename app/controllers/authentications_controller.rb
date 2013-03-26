class AuthenticationsController < ApplicationController
  
  def create
    auth = Authentication.welcomes request.env['omniauth.auth']
    
    if auth
      set_current_user auth.user

      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect :user, current_user
      
    else
      flash[:error] = "Sign up failed."
      redirect_to root_url
      
    end
  end
end
