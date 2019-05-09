class CreateHistoricalQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :historical_quotes do |t|
      t.string :symbol
      t.date :quote_date
      t.decimal :open
      t.decimal :high_sub_low
      t.decimal :close
      t.decimal :change_percent
      t.decimal :change_over_time

      t.timestamps
    end
  end
end
