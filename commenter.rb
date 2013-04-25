class Commenter
  def comment_last_line(filename)
    lines = read_lines(filename)
    lines[lines.count - 1] = comment(lines.last)

    write_back_lines(filename, lines)
  end

  def uncomment_last_line(filename)
    lines = read_lines(filename)
    lines[lines.count - 1] = uncomment(lines.last)

    write_back_lines(filename, lines)
  end

  def comment(line)
    if !line.strip.start_with?("#")
      return "##{line}" 
    else
      return line
    end
  end

  def uncomment(line)
    if line.strip.start_with?("#")
      line[0] = ""
    end
    line
  end

  private

  def read_lines(filename)
    lines = []
    File.open(filename, "r") do |f|
      f.each { |line| lines << line }
    end
    lines
  end

  def write_back_lines(filename, lines)
    File.open(filename, "w") do |f|
      lines.each { |line| f.puts line }
    end
  end
end
