class TickerSymbol < ApplicationRecord
  def self.no_symbols_loaded
    if TickerSymbol.count(:id) < 5
      return true
    end
    return false
  end
  def self.load_list symbol_list
    symbols = TickerSymbol.create(symbol_list)
  end
end
