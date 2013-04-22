require_relative "./tweet"


module Twitter
  describe Tweet do
    it "sets the id, name, text at creation" do
      t = Tweet.new(1, "masihjesus", "lorem ipsum")
    end

    it "formats itself for to_s" do
      long_text = "a" * 140
      t = Tweet.new(1, "masihjesus", long_text)
      t.to_s.should == "@#{t.screen_name}:\n#{long_text}"
    end

    it "knows the number of its lines" do
      multiline_text = "hello\n" * 10
      t = Tweet.new(1, "masihjesus", multiline_text)
      t.line_count.should == 10
    end
  end
end
