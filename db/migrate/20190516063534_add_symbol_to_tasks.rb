class AddSymbolToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :symb, :string
  end
end
