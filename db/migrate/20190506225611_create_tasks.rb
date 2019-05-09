class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :question
      t.text :content
      t.string :answer_1
      t.string :answer_2
      t.string :answer_3
      t.string :answer_4
      t.integer :num_responses
      t.decimal :answer_totals
      t.decimal :avg_answer

      t.timestamps
    end
  end
end
