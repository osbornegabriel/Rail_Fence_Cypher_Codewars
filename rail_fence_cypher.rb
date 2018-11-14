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

# For when the modulo 4 is 3
def decode_three(s,length)
  l_quarter = length/4
  line_one = s.slice!(0,l_quarter + 1)
  line_two = s
  line_three = line_two.slice!((-l_quarter -1),(l_quarter + 1))
  {line_one: line_one, line_two: line_two, line_three: line_three}
end

# For when the modulo 4 is 2 or 1
def decode_two(s, length)
  l_quarter = length/4
  line_one = s.slice!(0,l_quarter + 1)
  line_two = s
  line_three = line_two.slice!(-l_quarter,l_quarter)
  {line_one: line_one, line_two: line_two, line_three: line_three}
end

# For when modulo 4 is 0
def decode_zero(s, length)
  l_quarter = length/4
  line_one = s.slice!(0,l_quarter)
  line_two = s
  line_three = line_two.slice!(-l_quarter,l_quarter)
  {line_one: line_one, line_two: line_two, line_three: line_three}
end

def sort_into_lines(s,length)
  return decode_zero(s, length) if length % 4 == 0
  return decode_two(s, length) if length % 4 == 2 || length % 4 == 1
  return decode_three(s, length) if length % 4 == 3
end

def combine_lines(lines, length)
  # lines_reduce = lines.dup
  decoded_s = ''
  (length/4).times do
    decoded_s << lines[:line_one].slice!(0)
    decoded_s << lines[:line_two].slice!(0)
    decoded_s << lines[:line_three].slice!(0)
    decoded_s << lines[:line_two].slice!(0)
  end
  decoded_s + lines.values.reduce(:+)
end