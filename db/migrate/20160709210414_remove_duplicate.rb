class RemoveDuplicate < ActiveRecord::Migration
  def change
  	remove_column :statuses, :users_id
  end
end
