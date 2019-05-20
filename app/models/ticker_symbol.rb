class TickerSymbol < ApplicationRecord
  def self.no_symbols_loaded
    if TickerSymbol.count(:id) < 5
      return true
    end
    return false
  end
  def self.load_list symbol_list
    symbol_list.each do |s|
      TickerSymbol.create(id: s.child[:iexId], symb: s.child[:symbol], exchange: s.child[:exchange], name: s.child[:name])
    end
  end
end
