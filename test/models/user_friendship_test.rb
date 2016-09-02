require File.expand_path("../../test_helper", __FILE__)

class UserFriendshipTest < ActiveSupport::TestCase
	should belong_to(:user)
  should belong_to(:friend)

  test "That creating a friendship works without raising an exception" do
    assert_nothing_raised do
      UserFriendship.create user: users(:christina), friend: users(:will)
    end
  end

  test "that creating a friendship based on user id and friend id works" do
    UserFriendship.create user_id: users(:christina).id, friend_id: users(:will).id
    assert users(:christina).friends.include?(users(:will))
  end
end
