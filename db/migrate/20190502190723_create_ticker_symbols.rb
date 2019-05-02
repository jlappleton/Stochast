class CreateTickerSymbols < ActiveRecord::Migration[5.2]
  def change
    create_table :ticker_symbols do |t|
      t.string :symb
      t.string :name

      t.timestamps
    end
    add_index :ticker_symbols, :symb
  end
end
