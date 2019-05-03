class TickerSymbolController < ApplicationController
  def index
    @ticker = TickerSymbol.all
  end

  def show
  end
  
  def about
    require "github/markup"
    @readme = GitHub::Markup.render("README.md", File.read("README.md")).html_safe
  end
end
