module Twitter
  class Retweet
    attr_reader :count
    def initialize(count = 20)
      @count = count
    end

    def api_path
      "1.1/statuses/retweets_of_me.json"
    end
  end
end
