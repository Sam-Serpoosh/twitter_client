module Twitter
  module Data
    def self.one_tweet
      data_path = File.expand_path(File.dirname(__FILE__) + 
                                   "/one_tweet.data")
      File.open(data_path, "r") do |f|
        f.read
      end
    end

    def self.timeline
      data_path = File.expand_path(File.dirname(__FILE__) + 
                                   "/timeline.data")
      File.open(data_path, "r") do |f|
        f.read
      end
    end
  end
end