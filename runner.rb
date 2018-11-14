require_relative 'rail_fence_cypher.rb'

starting_string = "WEAREDISCOVEREDFLEEATONCE"
encoded_string = "WECRLTEERDSOEEFEAOCAIVDEN"

# p starting_string
# p rail_encode(starting_string)
# p rail_encode(starting_string) == encoded_string

# p encoded_string.length

p starting_string_two = "HELPMESORTI"

p encoded_string_two = rail_encode(starting_string_two)

p rail_decode(encoded_string_two)
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

