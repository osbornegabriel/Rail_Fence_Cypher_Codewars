# starting_string = "WEAREDISCOVEREDFLEEATONCE"
# encoded_string = "WECRLTEERDSOEEFEAOCAIVDEN"

def rail_encode(s)
  lines = {line_one: '', line_two: '', line_three: ''}
  s.chars.each.with_index do |letter, i|
    lines[:line_one] << letter if i % 4 == 0
    lines[:line_three] << letter if i % 4 == 2
    lines[:line_two] << letter if i % 4 == 1 || i % 4 == 3
  end
  lines.values.reduce(:+)
end

def rail_decode(s)
  length = s.length
  lines = sort_into_lines(s,length)
  combine_lines(lines,length)
end

private

  def create_line_one(s,length,l_quarter)
    n = length % 4 != 0 ? 1:0
    s.slice!(0, l_quarter + n)
  end

  def create_line_two(s)
    s
  end

  def create_line_three(s,length,l_quarter)
    return s.slice!((-l_quarter -1),(l_quarter + 1)) if length % 4 == 3
    s.slice!(-l_quarter,l_quarter)
  end

  def sort_into_lines(original_s,length)
    s = original_s.dup
    quarter = length/4
    line_one = create_line_one(s,length,quarter)
    line_two = create_line_two(s)
    line_three = create_line_three(s,length,quarter)
    {line_one: line_one, line_two: line_two, line_three: line_three}
  end

  def combine_lines(lines, length)
    decoded_s = ''
    (length/4).times do
      decoded_s << lines[:line_one].slice!(0)
      decoded_s << lines[:line_two].slice!(0)
      decoded_s << lines[:line_three].slice!(0)
      decoded_s << lines[:line_two].slice!(0)
    end
    decoded_s + lines.values.reduce(:+)
  end