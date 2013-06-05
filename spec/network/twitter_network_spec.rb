require_relative "../../lib/network/twitter_network"

module Twitter
  describe Network do
    context "#create_query" do
      it "encode params in www_form" do
        params = { "name" => "bob", "count" => 10 }
        query = Network.create_query(params)
        query.should == "name=bob&count=10"
      end
    end

    context "#no_query" do
      it "creates address with base twitter api & path" do
        path = "1.1/user_timeline"
        Network.create_address(path).to_s.should == 
          Network::BASE_URL + path
      end
    end

    context "#with_query" do
      it "creates address with base twitter api & path & query" do
        path = "1.1/user_timeline"
        query = Network.create_query({ "count" => 20 })
        Network.create_address(path, query).to_s.should == 
          Network::BASE_URL + path + "?" + query
      end
    end
  end
end
