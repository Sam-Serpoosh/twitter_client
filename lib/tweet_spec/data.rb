module Twitter
  module Data
    def self.one_tweet
      data_path = File.expand_path(File.dirname(__FILE__) + 
                                   "/one_tweet.data")
      File.open(data_path, "r") { |f| f.read }
    end

    def self.timeline
      data_path = File.expand_path(File.dirname(__FILE__) + 
                                   "/timeline.data")
      File.open(data_path, "r") { |f| f.read }
    end

    def self.friends
      data_path = File.expand_path(File.dirname(__FILE__) + 
                                   "/friends.json")
      File.open(data_path, "r") { |f| f.read }
    end

    def self.auth_data
      data_path = File.expand_path(File.dirname(__FILE__) + 
                                   "/auth_response_sample.data")
      File.open(data_path, "r") { |f| f.read }
    end
    
    def self.one_friend
      data_path = File.expand_path(File.dirname(__FILE__) + 
                                   "/one_friend.json")
      File.open(data_path, "r") { |f| f.read }
    end

    def self.last_friend
      data_path = File.expand_path(File.dirname(__FILE__) + 
                                   "/last_friend.json")
      File.open(data_path, "r") { |f| f.read }
    end
  end
end
