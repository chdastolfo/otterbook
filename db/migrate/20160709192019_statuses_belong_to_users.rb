class StatusesBelongToUsers < ActiveRecord::Migration
  def up
  	change_table :statuses do |t|
  		t.belongs_to :users 
  	end
  end
end
