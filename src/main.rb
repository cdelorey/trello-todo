# trello-todo
# 
# This app links tasks between the Trello and Todoist services.
# It simplifies the workflow in which high-level planning is done in Trello
# and low-level task management is done in Todoist by automatically transfering
# changes made in one service to the other.

require 'sinatra'
require 'trello'
require 'todoist'
require_relative 'cards'
require_relative 'tasks'
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
  include Tasks
end

# Database --------------------------------------------------------------------
DataMapper.setup(:default, ENV['DATABASE_URL'] || 
  "sqlite3://#{Dir.pwd}/development.db")
DataMapper.finalize
DataMapper.auto_upgrade!
DataMapper.auto_migrate! 

# Routes ----------------------------------------------------------------------
get '/' do
  "It works."
end

get '/trello' do
  
end

