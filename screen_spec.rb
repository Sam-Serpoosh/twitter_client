require_relative "screen"

module Twitter
  describe Screen do
    describe "creation of tweets directory" do
      before do
        remove_tweets_directory
      end

      after do
        remove_tweets_directory
      end

      context "directory does not exist" do
        it "is creating a directory for tweets" do
          Screen.create_tweets_directory
          Dir::exist?(Screen::DIR).should be_true
        end
      end

      context "directory already exist" do
        it "doesn't create the tweets directory" do
          Dir.stub(:exist?) { true }
          Dir.should_not_receive(:mkdir)

          Screen.create_tweets_directory
          Dir.stub(:exist?) { false } #cause of after
        end
      end

      def remove_tweets_directory
        File::delete(Screen::TWEETS_PATH) if File::exist?(Screen::TWEETS_PATH)
        Dir::rmdir(Screen::DIR) if Dir::exist?(Screen::DIR)
      end
    end
  end
end
