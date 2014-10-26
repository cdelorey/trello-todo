require 'data_mapper'
require_relative 'tasks'

DOING_LIST_ID = "5206965b344ba1b52f000610"
DONE_LIST_ID = "5206965b344ba1b52f000611"

##
# Card
#
# A Trello card.
class Card
 include DataMapper::Resource
 
 property :id, String, :key => true
 property :name, String, :required => true

 has n, :tasks, :constraint => :destroy 
end

module Cards
  extend self

  def me
    @me ||= Trello::Member.find("me")
  end

  def move_cards_from_trello_to_todoist
    trello_cards = get_cards_from_trello
    if trello_cards
      store_cards_in_database(trello_cards)
      Tasks.create_todoist_tasks(trello_cards)
    end
  end

  # takes a list of cards and removes all cards that are already stored in database
  def filter_cards(cards)
    cards = Array(cards) unless cards.respond_to?(:count) 
    return cards.select do |card|
      Card.get(card.id) == nil
    end
  end

  # retrieves all cards from the Doing list in Trello
  def get_cards_from_trello
    list = get_doing_list
    return list.cards
  end

  # returns true if I am assigned as a member to this card
  def am_member?(card)
    # this works because I'm the only possible member.
    # if this changes, this method will have to search the members list instead
    card.members.first == me 
  end

  def assign_cards_to_me(cards)
    cards.each do |card|
      card.add_member(me) unless am_member?(card)
    end
  end

  def unassign_me_from_cards(cards)
    cards.each do |card|
      if card.members
        card.remove_member(me)
      end
    end
  end

  # moves given card from doing list to done list
  def move_to_done_list(card)
    trello_card = Trello::Card.find(card.id)
    trello_card.move_to_list(DONE_LIST_ID)
    Tasks.delete_task(card)
    card.destroy
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
    cards = filter_cards(cards)
    if cards
      cards.each do |card|
        create_card(card.id, card.name)
      end
    end
  end
end


