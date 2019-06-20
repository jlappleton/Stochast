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
  def get_iex_json api_call
    iex_token = Rails.application.credentials.iex[:publishable]
    url = URI.parse("https://cloud.iexapis.com/stable/" + api_call + "?token=" + iex_token.to_s)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new url.request_uri
    @resp = http.request(req)
    @resp.body
  end
  ##
  # home page for site, displays all available symbols
  def index
    @tickers = TickerSymbol.all
  end
  ##
  # renders page that displays info on a single symbol
  def show
    t_symbol = params[:id]
    @symb = TickerSymbol.find_by symb: t_symbol
    @task = Task.find_by symb: t_symbol
    if @task.nil? or 0.75 > rand
      @news_url = "stock/" + t_symbol + "/news/last/5"
      @news = JSON.parse( get_iex_json( @news_url ) )
      @news.each do |n|
        id =n["datetime"]
        unless Task.exists? id
          @task = Task.create(id: id, question: "How will this affect " + t_symbol, content: n["source"] + " -- " + n["summary"], avg_answer: 0.5, symb: t_symbol, link: n["url"] )
        end
      end
    end
    @task = Task.where(symb: t_symbol)
    @task = @task[rand(@task.length)]
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
  ##
  # adds a symbol to the database for tracking
  def add
    unless TickerSymbol.where(symb: params['new_symbol']).nil?
      url = 'stock/' + params['new_symbol'] + '/company'
      company_data = JSON.parse( get_iex_json( url ) )
      print company_data
      unless company_data == 'Unknown symbol'
          TickerSymbol.create( symb: company_data["symbol"], name: company_data["companyName"], exchange: company_data["exchange"], industry: company_data["industry"], sector: company_data["sector"] )
      end
    end
    render('covered_symbols')
  end
  ##
  # removes a symbol from the database
  def remove
    TickerSymbol.where(symb: params['symb']['name']).destroy_all
    render('covered_symbols')
  end
end
