require_relative 'rail_fence_cypher.rb'

starting_string = "WEAREDISCOVEREDFLEEATONCE"
encoded_string = "WECRLTEERDSOEEFEAOCAIVDEN"

p starting_string
p rail_encode(starting_string)
p rail_encode(starting_string) == encoded_string
