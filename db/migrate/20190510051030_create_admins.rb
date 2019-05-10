class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :first
      t.string :last
      t.timestamps
    end
  end
end
