require_relative "../tweet/parser"
require_relative "./data"

module Twitter
  describe Parser do
    let(:all_tweets) { Data.timeline }
    let(:friends) { Data.friends }
    let(:parser) { Parser.new(Factory.new) }

    context "tweets" do
      it "parses a collection of tweets" do
        tweets = parser.get_tweets(all_tweets)

        tweets.count.should == 20
        tweets.first.screen_name.should == "masihjesus"
        tweets.first.text.should include "little bit"
      end 
    end

    context "friends" do
      it "parses a collection of users" do
        users = parser.users_from(friends)

        users.count.should == 18
        users.last.id.should == 27674040
        users.last.screen_name.should == "keltonlynn"
      end
    end
  end
end
