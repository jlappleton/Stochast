class TickerSymbolController < ApplicationController
  def get_iex_json_with_filters api_call
    iex_token = Rails.application.credentials.iex[:publishable]
    url = URI.parse("https://cloud.iexapis.com/stable/" + api_call + "&token=" + iex_token.to_s)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new url.request_uri
    @resp = http.request(req)
    @resp.body
  end
  ##
  # home page for site, displays all available symbols
  def index
    @ticker = TickerSymbol.all
  end
  ##
  # renders page that displays info on a single symbol
  def show
    t_symbol = params[:id]
    @symb = TickerSymbol.find_by symb: t_symbol
    @task = Task.find_by symb: t_symbol
    if @task.nil?
      @task = Task.find (1 + rand(Task.all.count))
    end
    @url = "stock/" + t_symbol + "/intraday-prices/?chartIEXOnly=true&filter=minute,average,high,low,open,close"
    @intraday = JSON.parse(get_iex_json_with_filters(@url)).select { |q| q["average"] }
    @id_chart_data = @intraday.map { |q| [q["minute"], q["average"]] }
    @vol_chart_data = @intraday.map { |q|  [ q["minute"], (q["high"] - q["low"]) ] }
    @updown_id_data = @intraday.map { |q| [q["minute"], (q["open"] - q["close"]) ] }
  end
  ##
  # renders the github md to html for an about page
  def about
    require "github/markup"
    @readme = GitHub::Markup.render("README.md", File.read("README.md")).html_safe
  end
end
