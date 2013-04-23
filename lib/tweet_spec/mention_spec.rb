require_relative "../tweet/mention"

module Twitter
  describe Mention do
    it "has the API path" do
      subject.api_path.should == "1.1/statuses/mentions_timeline.json"
    end

    it "limits the count to 20 by default" do
      subject.count.should == 20
    end
  end
end
