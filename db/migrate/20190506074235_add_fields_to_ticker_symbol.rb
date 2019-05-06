class AddFieldsToTickerSymbol < ActiveRecord::Migration[5.2]
  def change
    add_column :ticker_symbols, :exchange, :string
    add_column :ticker_symbols, :industry, :string
    add_column :ticker_symbols, :sector, :string
  end
end
