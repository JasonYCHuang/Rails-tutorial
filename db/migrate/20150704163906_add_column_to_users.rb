class AddColumnToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :role, :integer
    add_index  :users, :role

  	add_column :users, :name, :string
  end
end
