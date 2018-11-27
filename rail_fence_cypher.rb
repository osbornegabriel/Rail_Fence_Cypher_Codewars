# # starting_string = "WEAREDISCOVEREDFLEEATONCE"
# # encoded_string = "WECRLTEERDSOEEFEAOCAIVDEN"

#########################
###### RAIL ENCODER #####
#########################

def rail_encode(s,rail_count)
  phrase = s.dup
  rail_indexes = Array(0..(rail_count-1))
  rails = create_rails(rail_indexes)
  lines = build_lines(phrase,rails,rail_indexes)
  lines.values.reduce(:+)
end

def create_rails(rail_indexes)
  lines = {}
  rail_indexes.each do |i|
    lines[i] = ''
  end
  lines
end

def build_lines(s,rails,rail_indexes)
  middle_rail_indexes = rail_indexes[1..-2]
  last_index = rail_indexes.last
  until s == ''
    slice_to_rail(rails[0],s)
    middle_rail_indexes.each{|i| slice_to_rail(rails[i],s)}
    slice_to_rail(rails[last_index],s)
    middle_rail_indexes.reverse.each{|i| slice_to_rail(rails[i],s)}
  end
  rails
end

def slice_to_rail(rail,s)
  rail << s.slice!(0).to_s
end

########################
##### RAIL DECODER #####
########################

def rail_decode(s,rail_count)
  phrase = s.dup
  lines = find_lines(phrase,rail_count)
  assemble_lines(lines)
end

def assemble_lines(lines)
  decoded_s = ''
  lines[:first_line].size.times do
    decoded_s += lines[:first_line].slice!(0)
    decoded_s += slice_mid_lines(lines[:middle_lines])
    decoded_s += lines[:last_line].slice!(0).to_s
    decoded_s += slice_mid_lines_rev(lines[:middle_lines])
  end
  decoded_s
end

def slice_mid_lines(middle_lines)
  letters = ''
  middle_lines.each{|line| letters += line.slice!(0).to_s}
  letters
end

def slice_mid_lines_rev(middle_lines)
  slice_mid_lines(middle_lines.reverse)
end

def find_lines(phrase,rail_count)
  last_line = find_last_line(phrase,rail_count)
  first_line = find_first_line(phrase,rail_count)
  middle_lines = find_middle_lines(phrase,rail_count-2)
  {first_line: first_line, middle_lines: middle_lines, last_line: last_line}
end

def find_last_line(s,rail_count)
  one_sequence = ((rail_count-2) * 2) + 2
  sequences = s.length / one_sequence
  remainder = s.length % one_sequence
  sequences += 1 if remainder > one_sequence / 2
  s.slice!(-sequences..-1)
end

def find_first_line(s, rail_count)
  length = s.length
  one_sequence = ((rail_count-2) * 2) + 1
  sequences = length / one_sequence
  sequences += 1 if length % one_sequence > 0
  s.slice!(0,sequences)
end

def find_middle_lines(s,number_of_lines)
  length = s.length
  one_sequence = number_of_lines * 2
  number_of_sequences = length / one_sequence
  extra_letters_count = length % one_sequence
  slice_size = number_of_sequences * 2
  if extra_letters_count > number_of_lines
    s.reverse!
    extra_letters_count /= 2
    middle_lines = divide_middle_lines(s,number_of_lines,extra_letters_count,slice_size)
    middle_lines.map{|a| a.reverse}
  else
    divide_middle_lines(s,number_of_lines,extra_letters_count,slice_size)
  end
end

def divide_middle_lines(s,number_of_lines,extra_letters_count,slice_size)
  middle_lines = Array.new
  number_of_lines.times do |i|
    middle_lines[i] = s.slice!(0, slice_size).chars
    if extra_letters_count > 0
      middle_lines[i].push(s.slice!(0))
      extra_letters_count -= 1
    end
  end
  middle_lines
end