require_relative "./commenter"

describe Commenter do
  context "Commenting a line" do
    it "comments a line" do
      line = "foo bar"
      subject.comment(line).should == "#" + line 
    end

    it "does not comment line if it's already commented" do
      subject.comment("#foo bar").should == "#foo bar"
    end

    it "uncomments a line" do
      subject.uncomment("#foo bar").should == "foo bar"
    end

    it "does not uncommend a non-comment line" do
      subject.uncomment("foo bar").should == "foo bar"
    end

  end

  context "Commenting a last line of a file" do
    before do
      @filename = "foo.txt"
    end
    
    after do
      File.delete(@filename) if File.exists?(@filename)
    end
    
    it "comments the last line of a file" do
      create_test_file("foo\nbar\nbaz")
      subject.comment_last_line(@filename)
      lines = []
      File.open(@filename, "r") do |f|
        f.each { |line| lines << line }
      end
      lines.last.chop.should == "#baz"
    end

    it "uncomments the last line of a file" do
      create_test_file("foo\nbar\n#baz")
      subject.uncomment_last_line(@filename)
      lines = []
      File.open(@filename, "r") do |f|
        f.each { |line| lines << line }
      end
      lines.last.chop.should == "baz"
    end

    def create_test_file(text)
      File.open(@filename, "w") do |f|
        f.write text
      end
    end
  end
end
