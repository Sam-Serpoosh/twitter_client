require_relative "./parser"
require_relative "./data"

module Twitter
  describe Parser do
    let(:all_tweets) { Data.timeline }
    let(:client) { Factory.new }
    let(:parser) { Parser.new(client) }

    it "gets a collection of tweets" do
      tweets = parser.get_tweets(all_tweets)

      tweets.count.should == 20
      tweets.first.screen_name.should == "masihjesus"
      tweets.first.text.should include "little bit"
    end 
  end
end
