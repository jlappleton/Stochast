class CreatePredictions < ActiveRecord::Migration[5.2]
  def change
    create_table :predictions do |t|
      t.string :symbol
      t.decimal :prediction_open
      t.decimal :prediction_close
      t.decimal :prediction_trend

      t.timestamps
    end
  end
end
