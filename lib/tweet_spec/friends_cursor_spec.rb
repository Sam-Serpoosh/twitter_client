require_relative "../tweet/friends_cursor"

module Twitter
  describe FriendsCursor do
    let(:cursor) { FriendsCursor.new(1, 2) }

    it "sets the previous cursor at creation" do
      cursor.previous_cursor.should == 1
    end

    it "sets the next cursor at creation" do
      cursor.next_cursor.should == 2
    end

    it "knows when it is the last cursor" do
      cursor = FriendsCursor.new(1, 0)
      cursor.should be_last
    end

    it "returns the next cursor" do
      cursor = FriendsCursor.new(0, 1)
    end
  end
end
