require_relative "./tweet"

module Twitter
  describe Tweet do
    it "formats itself for to_s" do
      t = Tweet.new("masihjesus", "Lorem ipsum dollar ammet")
      t.to_s.should == "@#{t.screen_name}:\n\t#{t.text}"
    end
  end
end
