require 'sinatra'
require 'trello'
require 'todoist'
require_relative 'cards'
require_relative 'config_keys' # temporary

include Trello

# Configuration ---------------------------------------------------------------
Trello.configure do |config|
  config.developer_public_key = TRELLO_DEVELOPER_PUBLIC_KEY
  config.member_token = TRELLO_MEMBER_TOKEN
end

Todoist::Base.setup(TODOIST_API_TOKEN)

helpers do
  include Cards
end

# Database --------------------------------------------------------------------
DataMapper.setup(:default, ENV['DATABASE_URL'] || 
  "sqlite3://#{Dir.pwd}/development.db")
DataMapper.finalize
DataMapper.auto_upgrade!
DataMapper.auto_migrate! # temporary? necessary only for testing?

# Routes ----------------------------------------------------------------------
get '/' do
  # TESTING:
  #test_cards = get_cards_from_trello
  #    test_cards.each do |card|
  #      puts card.name
  #      puts card.id
  #    end
  store_cards_in_database(get_cards_from_trello)
  Card.each do |card|
    puts card.name
    puts card.id
  end
  "It works."
end

