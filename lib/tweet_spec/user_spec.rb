require_relative "../tweet/user"

describe User do
  let(:user) { User.new(1, "masihjesus") }

  it "sets the id in creation" do
    user.id.should == 1
  end

  it "sets the user screen name at creation" do
    user.screen_name.should == "masihjesus"
  end
end
