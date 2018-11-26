# # starting_string = "WEAREDISCOVEREDFLEEATONCE"
# # encoded_string = "WECRLTEERDSOEEFEAOCAIVDEN"

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

def build_lines(phrase,rails,rail_indexes)
  middle_rail_indexes = rail_indexes[1..-2]
  last_index = rail_indexes.last
  until phrase == ''
    rails[0] << phrase.slice!(0).to_s
    middle_rail_indexes.each{|i| rails[i] << phrase.slice!(0).to_s}
    rails[last_index] << phrase.slice!(0).to_s
    middle_rail_indexes.reverse.each{|i| rails[i] << phrase.slice!(0).to_s}
  end
  rails
end

def rail_decode(s,rail_count)
  lines = find_lines(s,rail_count)
  assemble_lines(lines,rail_count)
end

def assemble_lines(lines,rail_count)
  decoded_s = ''
  size_of_middle = rail_count - 2
  p "inside assemble_lines"
  p lines
  lines[:middle_line] = lines[:middle_line][0].join
  lines[:first_line].size.times do |i|
    decoded_s += lines[:first_line].slice!(0)
    decoded_s += lines[:middle_line].slice!(0) || ''
    decoded_s += lines[:last_line].slice!(0) || ''
    decoded_s += lines[:middle_line].slice!(0) || ''
    p decoded_s
  end
  decoded_s
end

def find_lines(s,rail_count)
  phrase = s.dup
  last_line = find_last_line(phrase,rail_count)
  first_line = find_first_line(phrase,rail_count)
  middle_line = find_middle_lines(phrase,rail_count-2)
  {first_line: first_line, middle_line: middle_line, last_line: last_line}
end

def find_middle_lines(s,number_of_lines)
  middle_lines = []
  length = s.length
  one_sequence = number_of_lines * 2
  number_of_sequences = length / one_sequence
  extra_letters_count = length % one_sequence
  slice_size = number_of_sequences * 2

  if extra_letters_count == 0
    # 'cool'
    # all lines are same length
    number_of_lines.times do |i|
      middle_lines[i] = s.slice!(0, slice_size).chars
    end
  elsif extra_letters_count <= number_of_lines
    # do nothing
    number_of_lines.times do |i|
      middle_lines[i] = s.slice!(0, slice_size).chars
      p "inside elsif!"
      if extra_letters_count > 0
        middle_lines[i].push(s.slice!(0))
        extra_letters_count -= 1
      end
      p middle_lines
    end
  elsif extra_letters_count > number_of_lines
    s.reverse!
    extra_letters_count /= 2
    number_of_lines.times do |i|
      middle_lines[i] = s.slice!(0, slice_size).chars
      if extra_letters_count > 0
        middle_lines[i].push(s.slice!(0))
        extra_letters_count -= 1
      end
      middle_lines[i].reverse!
    end
  end
  p "these are your middle lines"
  p middle_lines
  # length to slice is the
  # number_of_sequences * 2
  # + 1 if there are still extra letters remaining

end

def find_last_line(s,rail_count)
  length = s.length
  one_sequence = ((rail_count-2) * 2) + 2
  sequences = length / one_sequence
  remainder = length % one_sequence
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

# def rail_encode(s)
#   lines = {line_one: '', line_two: '', line_three: ''}
#   s.chars.each.with_index do |letter, i|
#     lines[:line_one] << letter if i % 4 == 0
#     lines[:line_three] << letter if i % 4 == 2
#     lines[:line_two] << letter if i % 4 == 1 || i % 4 == 3
#   end
#   lines.values.reduce(:+)
# end

# def rail_decode(s)
#   length = s.length
#   lines = sort_into_lines(s,length)
#   combine_lines(lines,length)
# end

# private

#   def create_line_one(s,length,l_quarter)
#     n = length % 4 != 0 ? 1:0
#     s.slice!(0, l_quarter + n)
#   end

#   def create_line_two(s)
#     s
#   end

#   def create_line_three(s,length,l_quarter)
#     return s.slice!((-l_quarter -1),(l_quarter + 1)) if length % 4 == 3
#     s.slice!(-l_quarter,l_quarter)
#   end

#   def sort_into_lines(original_s,length)
#     s = original_s.dup
#     quarter = length/4
#     line_one = create_line_one(s,length,quarter)
#     line_two = create_line_two(s)
#     line_three = create_line_three(s,length,quarter)
#     {line_one: line_one, line_two: line_two, line_three: line_three}
#   end

#   def combine_lines(lines, length)
#     decoded_s = ''
#     (length/4).times do
#       decoded_s << lines[:line_one].slice!(0)
#       decoded_s << lines[:line_two].slice!(0)
#       decoded_s << lines[:line_three].slice!(0)
#       decoded_s << lines[:line_two].slice!(0)
#     end
#     decoded_s + lines.values.reduce(:+)
#   end