require_relative "../tweet/mention"

module Twitter
  describe Mention do
    it "has the API path" do
      subject.api_path.should == "1.1/statuses/mentions_timeline.json"
    end

    it "limits the count to 20 by default" do
      subject.count.should == 20
    end

    context "#network" do
      before do
        @network = stub
        @mention = Mention.new(count: 20, network: @network)
        @query = @mention.query
        @api_path = @mention.api_path
      end

      it "calls fetch_response on network" do
        @network.should_receive(:fetch_response).with(@api_path, @query)
        @mention.fetch_mentions
      end
    end
  end
end
