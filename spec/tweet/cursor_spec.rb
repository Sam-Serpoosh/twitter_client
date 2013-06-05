require_relative "../../lib/tweet/cursor"

module Twitter
  describe Cursor do
    let(:cursor) { Cursor.new(1, 2) }

    it "sets the previous cursor at creation" do
      cursor.previous_cursor.should == 1
    end

    it "sets the next cursor at creation" do
      cursor.next_cursor.should == 2
    end

    it "knows when it has no next cursor" do
      cursor = Cursor.new(1, 0)
      cursor.has_next?.should be_false
    end

    it "returns the next cursor" do
      cursor = Cursor.new(0, 1)
    end
  end
end
