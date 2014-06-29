require 'sinatra'
require 'trello'
require 'todoist'
require_relative 'cards'
require_relative 'config_keys' # temporary

include Trello

puts "In Main"

# Configuration ---------------------------------------------------------------
Trello.configure do |config|
  config.developer_public_key = TRELLO_DEVELOPER_PUBLIC_KEY
  config.member_token = TRELLO_MEMBER_TOKEN
end

Todoist::Base.setup(TODOIST_API_TOKEN)

# Database --------------------------------------------------------------------
DataMapper.setup(:default, ENV['DATABASE_URL'] || 
  "sqlite3://#{Dir.pwd}/development.db")
DataMapper.finalize
DataMapper.auto_upgrade!

# Routes ----------------------------------------------------------------------
get '/' do 
  "It works."
end

