require_relative "../../lib/tweet/following"
require_relative "./data"

module Twitter
  describe Following do
    let(:following) { Following.new("masihjesus") }

    context "#creation" do
      it "sets the screen name at creation" do
        following.screen_name.should == "masihjesus"
      end

      it "knows the api_path for following" do
        following.api_path.should == "1.1/friends/list.json"
      end

      it "sets the next cursor to -1 by default" do 
        following.next_cursor_value.should == -1
      end

      it "skips the users statuses by default" do
        following.skip_status.should be_true
      end

      it "does not include the user entities by default" do
        following.include_user_entities.should be_false
      end

      it "can include the user entities" do
        f = Following.new("masihjesus", include_user_entities: true)
        f.include_user_entities.should be_true
      end

      it "lets you to set the network" do
        network = double
        network.should_receive(:create_query)
        f = Following.new("masihjesus", network: network)
      end
    end

    context "#friends" do
      let(:one_friend) { Data.one_friend }

      it "creates the next cursor" do
        user = stub.as_null_object
        following.add_friends_and_move_to_next_cursor(user, one_friend)
        following.next_cursor.next_cursor.should == 1333504313713126852
      end

      it "add friends to the user" do
        user = User.new("masihjesus")
        following.add_friends_and_move_to_next_cursor(user, one_friend)
        user.friends.count.should == 1
        user.friends[0].screen_name.should == "Bob"
      end

      it "fetches friends until the last cursor" do
        network = stub.as_null_object
        network.stub(:fetch_response) { Data.last_friend }
        following = Following.new("masihjesus", network: network)
        following.query.should include("cursor=-1")

        following.friends

        following.next_cursor.has_next?.should be_false
      end

      it "fetches the latest tweets of friends" do
        following = StubFollowing.new("masihjesus", network: stub.as_null_object)
        tweets = following.friends_latest_tweets
        tweets.first.text.should == "lorem ipsum"
        tweets.last.text.should == "dollar amet"
      end
    end
  end
end

module Twitter
  class StubFollowing < Following
    def friends
      [User.new("Bob"), User.new("Alice")]
    end

    def user_timeline(screen_name)
      [Tweet.new(1, "Bob", "lorem ipsum"), 
       Tweet.new(2, "Alice", "dollar amet")]
    end
  end
end
