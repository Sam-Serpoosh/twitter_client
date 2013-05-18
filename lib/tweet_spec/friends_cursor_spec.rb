require_relative "../tweet/friends_cursor"

module Twitter
  describe FriendsCursor do
    let(:users_data) do
      users = []
      users << { id: 1, screen_name: "bob" }
      users << { id: 2, screen_name: "alice" }
    end
    let(:cursor) { FriendsCursor.new(1, 2, users_data) }

    it "sets the previous cursor at creation" do
      cursor.previous_cursor.should == 1
    end

    it "sets the next cursor at creation" do
      cursor.next_cursor.should == 2
    end

    it "has the users data array" do
      cursor.users_data.should == users_data
    end

    it "knows when it is the last cursor" do
      cursor = FriendsCursor.new(1, 0, [])
      cursor.should be_last
    end

    it "returns the next cursor" do
      cursor = FriendsCursor.new(0, 1, [])

    end
  end
end
