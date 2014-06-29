require 'data_mapper'

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

helpers do
  ##
  # load_cards
  #
  # Loads the trello cards from the "Doing" list on the programming board
  # into the database.
  def get_cards_from_trello
    board = get_programming_board
  end

end


module Cards
  def get_programming_board
    
  end
end


