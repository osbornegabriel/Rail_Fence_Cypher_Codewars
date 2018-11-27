require_relative 'rail_fence_cypher.rb'

starting_string = "WEAREDISCOVEREDFLEEATONCE"
encoded_string = "WECRLTEERDSOEEFEAOCAIVDEN"

p rail_encode(starting_string,3)
p encoded_string == rail_encode(starting_string,3)
p rail_decode(encoded_string,3)
p ''

# p starting_string
# p rail_encode(starting_string)
# p rail_encode(starting_string) == encoded_string

# p encoded_string.length
starting_string_one = "HELPMESORT"
starting_string_two = "HELPMESORTI"
starting_string_three = "HELPMESORTIT"
starting_string_four = "HELPMESORTIT!"

p encoded_string_one = rail_encode(starting_string_one,3)
p encoded_string_one == rail_encode(starting_string_one,3)
p rail_decode(encoded_string_one,3)
# p "Now to check the decode"
# p rail_decode(encoded_string_one) == starting_string_one
# p rail_decode(encoded_string_one) == starting_string_one
# p decoded_string
puts ""

p encoded_string_two = rail_encode(starting_string_two,3)
p rail_decode(encoded_string_two,3)
# p rail_decode(encoded_string_two) == starting_string_two
puts ""

p encoded_string_three = rail_encode(starting_string_three,3)
p rail_decode(encoded_string_three,3)
# p rail_decode(encoded_string_three) == starting_string_three
puts ""

p encoded_string_four = rail_encode(starting_string_four,3)
p rail_decode(encoded_string_four,3)
# p rail_decode(encoded_string_four) == starting_string_four

=begin

H   M.  R
 E P E O T
  L   S
0,1,2
3,4,5,6,7
8,9

H   M.  R
 E P E O T
  L   S.  I

0,1,2  3,4,5,6,7  8,9,10

H   M.  R
 E P E O T T
  L   S.  I
0,3,9,4 1,5,10,6  2,7,11,8

0,1,2
3,4,5,6,7,8
9,10,11

H   M.  R.  !
 E P E O T T
  L   S.  I

0,1,2,3  4,5,6,7,8,9  10,11,12

=end

