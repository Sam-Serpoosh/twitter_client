require_relative "../tweet/user"

module Twitter
  describe User do
    let(:user) { User.new(1, "masihjesus") }

    it "sets the id in creation" do
      user.id.should == 1
    end

    it "sets the user screen name at creation" do
      user.screen_name.should == "masihjesus"
    end

    it "has friends and it's empty at the beginning" do
      user.friends.should be_empty
    end

    it "add to the existing friends" do
      user = User.new(1, "masihjesus")
      bob = User.new(2, "bob")
      alice = User.new(3, "alice")
      user.add_friends([bob])
      user.add_friends([alice])

      user.friends.should == [bob, alice]
    end
  end
end
