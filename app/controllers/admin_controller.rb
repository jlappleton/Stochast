class AdminController < ApplicationController
  def login
    auth_response = request.env["omniauth.auth"]
    if Admin.check_for_access(auth_response)
      session[:logged_in] = "true"
      flash["alert-info"] = "Login Successful"
    end
    redirect_to("/dashboard")
  end
  def logout
    reset_session
    flash["alert-danger"] = "You have logged out."
    redirect_to("/")
  end
  def dash
    if session[:logged_in].nil?
      flash["alert-danger"] = "Nope."
      redirect_to("/")
    end
  end
end
