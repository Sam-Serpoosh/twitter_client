require_relative "../tweet/retweet"

module Twitter
  describe Retweet do
    it "knows the path for th api" do
      subject.api_path.should == "1.1/statuses/retweets_of_me.json"
    end

    it "has 20 as the default count limit" do
      subject.count.should == 20
    end

    it "can change the count limit" do
      Retweet.new(count: 30).count.should == 30
    end

    context "#network" do
      before do
        @network = stub.as_null_object
        @rets = Retweet.new(network: @network)
        @api_path = @rets.api_path
        @query = @rets.query
      end

      it "calls fetch_response on network" do
        @network.should_receive(:fetch_response).with(@api_path, @query)
        @rets.fetch_retweets
      end
    end
  end
end
