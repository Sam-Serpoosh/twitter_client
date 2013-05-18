require_relative "../tweet/following"

module Twitter
  # change the ctor to the hash style!
  describe Following do
    let(:following) { Following.new("masihjesus") }

    it "sets the screen name at creation" do
      following.screen_name.should == "masihjesus"
    end

    it "knows the api_path for following" do
      following.api_path.should == "1.1/friends/list.json"
    end

    it "sets the cursor to -1 by default" do 
      following.cursor.should == -1
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
  end
end
