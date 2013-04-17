require_relative "./tweet"


module Twitter
  describe Tweet do
    it "formats itself for to_s" do
      long_text = "a" * 140
      t = Tweet.new("masihjesus", long_text)
      t.to_s.should == "@#{t.screen_name}:\n#{long_text}"
    end
  end
end
