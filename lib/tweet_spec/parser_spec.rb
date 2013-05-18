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

    context "friends_cursor" do
      it "parses the friends cursor" do
        cursor = parser.friends_cursor(friends)
        cursor.next_cursor.should == 1333504313713126852
        cursor.users_data.count.should == 18
        cursor.should_not be_last
      end
    end

    context "friends" do
      it "parses a collection of users" do
        cursor = parser.friends_cursor(friends)
        users = parser.users_from(cursor)

        users.count.should == 18
        users.last.id.should == 27674040
        users.last.screen_name.should == "keltonlynn"
      end

      it "returns empty when there is no users_data" do
        friends_cursor = stub(users_data: nil)
        users = parser.users_from(friends_cursor)
        users.should be_empty
      end
    end
  end
end
