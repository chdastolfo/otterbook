require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a user can have a correctly formatted profile name" do
  	user = User.new(first_name: 'Christina', last_name: "D'Astolfo", email: "chdastolfo@gmail.com")
  	user.password = user.password_confirmation = 'alskjdasd'

  	user.profile_name = 'tinadasty1'
  	assert user.valid?
  end
end
