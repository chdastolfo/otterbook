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
    assert users(:christina).pending_friends.include?(users(:will))
  end

  context "a new instance" do
    setup do
      @user_friendship = UserFriendship.new user: users(:christina), friend: users(:will)
    end

    should "have a pending state" do
      assert_equal "pending", @user_friendship.state
    end
  end
  
  context "#send_request_email" do
    setup do
      @user_friendship = UserFriendship.create user: users(:christina), friend: users(:will)
    end

    should "send an email" do
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        @user_friendship.send_request_email
      end
    end
  end

  context "#accept!" do
    setup do
      @user_friendship = UserFriendship.create user: users(:christina), friend: users(:will)
    end

    should "set the state to accepted" do
      @user_friendship.accept!
      assert_equal "accepted", @user_friendship.state
    end

    should "send an acceptance email" do
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        @user_friendship.accept!
      end
    end

    should "include the friend in the list of friends" do
      @user_friendship.accept!
      users(:christina).friends.reload
      assert users(:christina).friends.include?(users(:will))
    end
  end

  context ".request" do
    should "create two user friendships" do
      assert_difference 'UserFriendship.count', 2 do
        UserFriendship.request(users(:christina), users(:will))
      end
    end

    should "send a friend request email" do
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        UserFriendship.request(users(:christina), users(:will))
      end
    end
  end
end
