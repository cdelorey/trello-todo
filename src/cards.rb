require 'data_mapper'

DOING_LIST_ID = "5206965b344ba1b52f000610"

##
# Card
#
# A Trello card.
class Card
 include DataMapper::Resource
 
 property :id, String, :key => true
 property :name, String, :required => true

 # has n, :tasks, :constraint => :destroy 
end

module Cards
  def move_cards_from_trello_to_todoist
    trello_cards = filter_cards(get_cards_from_trello)
    unless trello_cards.nil?
      store_cards_in_database(trello_cards)
      create_todoist_tasks(trello_cards)
    end
  end

  # takes a list of cards and removes all cards that are already stored in database
  def filter_cards(cards)
    cards.select do |card|
      Card.get(card.id) == nil
    end
  end

  # creates tasks from card names and sends them to todoist
  def create_todoist_tasks(cards)
  end

  # retrieves all cards from the Doing list in Trello
  def get_cards_from_trello
    list = get_doing_list
    return list.cards
  end

  def get_doing_list
    Trello::List.find(DOING_LIST_ID) 
  end

  def create_card(id, name) 
    begin
      Card.create(:id => id, :name => name)
    rescue DataObjects::IntegrityError
      puts "card already exists in database"
    end
  end

  def store_cards_in_database(cards)
    # cards is a collection
    if cards.respond_to?(:count)
      cards.each do |card|
        create_card(card.id, card.name)
      end
    else # cards is a single card
      create_card(card.id, card.name)
    end
  end
end


