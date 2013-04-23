module Twitter
  class Screen
    BOUNDARY = "-" * 80

    def self.timeline(tweets)
      tweets.each do |t|
        puts BOUNDARY 
        puts t
        puts BOUNDARY 
      end
    end
  end
end
