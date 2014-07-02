include 'database_cleaner'

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner[:data_mapper].strategy = :transaction
    DatabaseCleaner[:data_mapper].clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner[:data_mapper].strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner[:data_mapper].start 
  end

  config.after(:each) do
    DatabaseCleaner[:data_mapper].clean 
  end

  config.around(:each) do |example|
    DatabaseCleaner[:data_mapper].cleaning do
      example.run
    end
  end
end

