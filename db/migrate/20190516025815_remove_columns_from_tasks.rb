class RemoveColumnsFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :answer_1, :string
    remove_column :tasks, :answer_2, :string
    remove_column :tasks, :answer_3, :string
    remove_column :tasks, :answer_4, :string
  end
end
