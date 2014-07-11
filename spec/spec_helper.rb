ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'factory_girl'
require 'dm-transactions'
require 'database_cleaner'
require File.expand_path '../../src/main.rb', __FILE__
require File.expand_path '../support/test_helpers.rb', __FILE__


module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end 
end

RSpec.configure do |c| 
  c.include RSpecMixin
  c.include FactoryGirl::Syntax::Methods
  c.include Tasks
  c.include Cards
  c.include TestHelpers

  # to run whole test suite including api specs:
  # ALL=true rspec spec
  c.filter_run_excluding api: true unless ENV['ALL']

  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/test.db")
  DataMapper.finalize
  c.before(:each) { DataMapper.auto_migrate! }
end 

FactoryGirl.definition_file_paths = %w{./factories ./test/factories ./spec/factories}
FactoryGirl.find_definitions