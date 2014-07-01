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

module Cards
  ##
  # load_cards
  #
  # Loads the trello cards from the "Doing" list on the programming board
  # into the database.
  def get_cards_from_trello
    list = get_doing_list
    return list.cards
  end

  def get_doing_list
    Trello::List.find("5206965b344ba1b52f000610") 
  end
end


