require 'data_mapper'
puts "In Cards"
##
# Card
#
# A Trello card.
class Card
 include DataMapper::Resource
 
 property :id, Integer, :key => true
 property :name, String, :required => true
 # has n, :tasks, :constraint => :destroy 
end

