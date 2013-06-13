require_relative "../../lib/tweet/parser"
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

      it "returns empty tweet when there's error" do
        tweet_response = %Q{ { "errors": "something went wrong" } }
        tweets = parser.get_tweets(tweet_response)
        tweets.first.should be_empty
      end
    end

    context "create_cursor_for" do
      it "parses the cursor" do
        cursor = parser.create_cursor_for(friends)
        cursor.next_cursor.should == 1421369440215956700
        cursor.has_next?.should be_true
      end

      it "returns 'last cursor' if there is any error" do
        friends_response = %Q{ { "errors": "somethign went wrong" } }
        cursor = parser.create_cursor_for(friends_response)
        cursor.has_next?.should be_false
      end
    end

    context "#any_error?" do
      it "knows when there is error in response" do
        response = { "errors" => "something went wrong" }
        parser.any_error?(response).should be_true
      end

      it "won't detect errors if resonse is not hash" do
        response = "bla bla"
        parser.any_error?(response).should be_false
      end
    end

    context "friends" do
      it "parses a collection of users" do
        users = parser.users_from(friends)

        users.count.should == 20
        users.last.id.should == 588743
        users.last.screen_name.should == "Bob"
      end

      it "parses users directly from json" do
        users = parser.users_from(Data.one_friend)
        users.count.should == 1
        users.first.screen_name.should == "Bob"
      end

      it "returns empty when there is no users data" do
        users = parser.users_from("{}")
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
