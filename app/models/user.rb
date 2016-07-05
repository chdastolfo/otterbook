class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :email, :password, :password_confirmation, :remember_me,
  :first_name, :last_name, :profile_name

  has_many :statuses

  def full_name
  	first_name.to_s + " " + last_name.to_s
  end
  
end
