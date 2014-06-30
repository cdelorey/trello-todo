ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'factory_girl'
require File.expand_path '../../src/main.rb', __FILE__


module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end 
end

RSpec.configure do |c| 
  c.include RSpecMixin
  c.include FactoryGirl::Syntax::Methods
  # to run whole test suite including api specs:
  # ALL=true rspec spec
  c.filter_run_excluding api: true unless ENV['ALL']
end 

FactoryGirl.definition_file_paths = %w{./factories ./test/factories ./spec/factories}
FactoryGirl.find_definitions