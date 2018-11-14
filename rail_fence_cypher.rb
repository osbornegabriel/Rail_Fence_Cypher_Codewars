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