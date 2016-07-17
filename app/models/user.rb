 class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :statuses

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true,
  						   uniqueness: true,
  						   format: {
  						   	with: /a-zA-Z0-9_-/,
  						   	message: 'You have to format your profile name correctly.'
  						   }

  def full_name
    "#{first_name.to_s} " " #{last_name.to_s}"
  end

end
