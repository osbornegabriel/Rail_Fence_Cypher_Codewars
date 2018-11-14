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
  return decode_four(s, length) if length % 4 == 0
end

def decode_four(s, length)
  p lines = sort_lines(s,length)

end

def sort_lines(s,length)
  l_quarter = length/4
  line_one = s.slice!(0,l_quarter)
  line_two = s
  line_three = line_two.slice!(-l_quarter,l_quarter)
  [line_one, line_two, line_three]
end