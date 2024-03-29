ENV['RACK_ENV'] = 'test'
ENV['APP_ENV'] = 'test'

require_relative File.join('..', 'app')

RSpec.configure do |config|
  include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  def app
    TwoFactorAuth::App
  end
end
