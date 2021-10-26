require 'dotenv'
require 'sinatra'
require 'sinatra/config_file'
require 'rack-flash'
require 'tilt/haml'

require_relative 'helpers/authentication'
require_relative 'helpers/data_mapper_setup'
require_relative 'routes/users'
require_relative 'routes/sessions'
require_relative 'routes/confirmations'
require_relative 'routes/protected'
require_relative 'lib/code_generator'
require_relative 'lib/message_sender'
require_relative 'lib/verification_sender'

# Load environment configuration
Dotenv.load

# Set the environment after dotenv loads
# Default to production
enviroment = (ENV['APP_ENV'] || ENV['RACK_ENV'] || :production).to_sym
set :environment, enviroment

require 'bundler'
Bundler.require :default, enviroment

module TwoFactorAuth
  class App < Sinatra::Base
    register Sinatra::ConfigFile
    config_file 'config/app.yml'
    Helpers::DataMapperSetup.setup(settings.database_url)

    helpers Helpers::Authentication

    enable :sessions
    use Rack::Flash
    set :root, File.dirname(__FILE__)



    register Routes::Users
    register Routes::Sessions
    register Routes::Confirmations
    register Routes::Protected

    get '/' do
      haml :'home/index'
    end
  end
end
