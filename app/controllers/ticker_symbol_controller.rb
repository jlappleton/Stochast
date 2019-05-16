class TickerSymbolController < ApplicationController
  ##
  # home page for site, displays all available symbols
  def index
    @ticker = TickerSymbol.all
  end
  ##
  # renders page that displays info on a single symbol
  def show
    @symb = TickerSymbol.find_by symb: params[:id]
    @task = Task.find_by symb: params[:id]
    if @task.nil?
      @task = Task.find (1 + rand(Task.all.count))
    end
  end
  ##
  # renders the github md to html for an about page
  def about
    require "github/markup"
    @readme = GitHub::Markup.render("README.md", File.read("README.md")).html_safe
  end
end
