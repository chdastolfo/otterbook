class RemoveExcessColumns < ActiveRecord::Migration
  def change
  	  remove_column :users, :first_name, :string
  	  remove_column :users, :last_name, :string
  	  remove_column :users, :profile_name, :string
  end
end
