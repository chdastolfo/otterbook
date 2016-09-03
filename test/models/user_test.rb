require File.expand_path("../../test_helper", __FILE__)

class UserTest < ActiveSupport::TestCase
	should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors(:first_name).empty?
  end

  test "a user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors(:last_name).empty?
  end

  test "a user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors(:profile_name).empty?
  end

  test "a user can have a correctly formatted profile name" do
  	user = User.new(first_name: 'Christina', last_name: "D'Astolfo", email: "chdastolfo@gmail.com")
  	user.password = user.password_confirmation = 'alskjdasd'

  	user.profile_name = 'tinadasty_1'
  	assert user.valid?
  end

  test "that no error is raised when trying to get to a users friends list" do
    assert_nothing_raised do
      users(:christina).friends
    end
  end

  test "that creating friendships on a user works" do
    users(:christina).pending_friends << users(:will)
    users(:christina).pending_friends.reload
    assert users(:christina).pending_friends.include?(users(:will))
  end

  test "that calling to_param on a user returns the profile_name" do
    assert_equal "tinadasty", users(:christina).to_param
  end
end
