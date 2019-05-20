class AddLinkToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :link, :string
  end
end
