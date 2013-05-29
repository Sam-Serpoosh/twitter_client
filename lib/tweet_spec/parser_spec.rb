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

    context "create_friends_cursor_for" do
      it "parses the friends cursor" do
        cursor = parser.create_friends_cursor_for(friends)
        cursor.next_cursor.should == 1333504313713126852
        cursor.should_not be_last
      end
    end

    context "friends" do
      it "parses a collection of users" do
        users = parser.users(friends)

        users.count.should == 18
        users.last.id.should == 27674040
        users.last.screen_name.should == "keltonlynn"
      end

      it "parses users directly from json" do
        users = parser.users(Data.one_friend)
        users.count.should == 1
        users.first.screen_name.should == "froginthevalley"
      end

      it "returns empty when there is no users data" do
        users = parser.users("{}")
        users.should be_empty
      end
    end

    context "authentication" do
      let(:auth_response) { Data.auth_data }
      it "returns ok when authentication is success" do
        auth_result = parser.authentication_result(auth_response)
        auth_result.should == "Authenticated"
      end

      it "returns 'Not Valid' when authentication is failure" do
        auth_result = parser.authentication_result("{}")
        auth_result.should == "Not Valid"
      end
    end
  end
end
