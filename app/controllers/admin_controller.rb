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
    # client = IEX::Api::Client.new(publishable_token: iex_token)
    if TickerSymbol.no_symbols_loaded
      iex_token = Rails.application.credentials.iex[:publishable]
      url = URI.parse("https://cloud.iexapis.com/stable/ref-data/symbols?token=" + iex_token.to_s)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      req = Net::HTTP::Get.new url.request_uri
      @resp = http.request(req)
      @symbol_list = JSON.parse(@resp.body) if @resp
      TickerSymbol.load_list @symbol_list
    end
  end
end
