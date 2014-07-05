require 'simplecov'

SimpleCov.start do
  add_filter "spec/"
end

ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'capybara/rspec'

require File.expand_path '../../../src/main.rb', __FILE__


RSpec.configure do |c|
  c.include Capybara::DSL
  c.include Tasks
  c.include Cards
end


Capybara.app = Sinatra::Application