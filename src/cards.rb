require 'data_mapper'
require_relative 'tasks'


DOING_LIST_ID = "5206965b344ba1b52f000610"

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

  def move_cards_from_trello_to_todoist
    trello_cards = get_cards_from_trello
    unless trello_cards.nil?
      store_cards_in_database(trello_cards)
      Tasks.create_todoist_tasks(trello_cards)
    end
  end

  # takes a list of cards and removes all cards that are already stored in database
  def filter_cards(cards)
    # cards is a collection
    if cards.respond_to?(:count)
      return cards.select do |card|
        Card.get(card.id) == nil
      end
    # cards is a single card object
    else
      if Card.get(cards.id) == nil
        return cards 
      else 
        return nil 
      end
    end
  end

  # retrieves all cards from the Doing list in Trello
  def get_cards_from_trello
    list = get_doing_list
    return list.cards
  end

  def assign_cards_to_me(cards)
    me = Trello::Member.find("me")
    cards.each do |card|
      unless(card.members.first == me)
        card.add_member(me)
      end
    end
  end

  def unassign_me_from_cards(cards)
    me = Trello::Member.find("me")
    cards.each do |card|
      unless(card.members == nil)
        card.remove_member(me)
      end
    end
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
    unless cards.nil?
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
end


