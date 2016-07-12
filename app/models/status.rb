class Status < ActiveRecord::Base
	#attr_accessor :content, :user_id
	belongs_to :user
end
