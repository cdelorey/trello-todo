require 'sinatra'
require 'trello'
require 'todoist'
require_relative 'config_keys'

include Trello

# Configuration ---------------------------------------------------------------
Trello.configure do |config|
  config.developer_public_key = TRELLO_DEVELOPER_PUBLIC_KEY
  config.member_token = TRELLO_MEMBER_TOKEN
end

Todoist::Base.setup(TODOIST_API_TOKEN)

# Routes ----------------------------------------------------------------------
get '/' do 
  "It works."
end

