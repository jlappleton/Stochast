class AdminController < ApplicationController
  def get_iex_hash api_call
    @resp = get_iex_json api_call
    @symbol_list = JSON.parse(@resp.body) if @resp
  end
  def get_iex_json api_call
    iex_token = Rails.application.credentials.iex[:publishable]
    url = URI.parse("https://cloud.iexapis.com/stable/" + api_call + "?token=" + iex_token.to_s)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new url.request_uri
    @resp = http.request(req)
  end
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
      return
    end
    #@symbols = get_iex_hash "ref-data/symbols"
  end
  def privacy_policy
  end
  def tos
  end
end
