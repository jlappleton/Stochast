class TickerSymbolController < ApplicationController
  ##
  # home page for site, displays all available symbols
  def index
    @ticker = TickerSymbol.all
  end
  ##
  # renders page that displays info on a single symbol
  def show
    @symb = {symb: "AAPL", name: "Apple Inc", exchange: "idk Whatever Exchange", industry: "Computers", sector: "software" }
    @task = {id: 1, question: "question text will be here, it should be kind of long but I would prefer if it stayed one sentence. Maybe two.", content: "https://someuri.com/whatever"}
  end
  ##
  # renders the github md to html for an about page
  def about
    require "github/markup"
    @readme = GitHub::Markup.render("README.md", File.read("README.md")).html_safe
  end
end
