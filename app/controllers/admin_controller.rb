class AdminController < ApplicationController
  def login
    auth_response = request.env["omniauth.auth"]
    if Admin.check_for_access(auth_response)
      session[:logged_in] = "true"
    end
    redirect_to("/dashboard")
  end
  def logout
    reset_session
    redirect_to("/")
  end
  def dash
    if session[:logged_in].nil?
      redirect_to("/")
    end
  end
end
