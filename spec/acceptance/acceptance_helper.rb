require 'simplecov'

SimpleCov.start do
  add_filter "spec/"
end

ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL 
end

require File.expand_path '../../../src/main.rb', __FILE__

Capybara.app = Sinatra::Application