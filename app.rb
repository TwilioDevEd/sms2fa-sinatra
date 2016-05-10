require 'sinatra/base'
require 'sinatra/config_file'
require 'tilt/haml'

require_relative 'helpers/datamapper_helper'
require_relative 'helpers/authentication'
require_relative 'routes/users'
require_relative 'routes/confirmations'
require_relative 'routes/protected'
require_relative 'lib/code_generator'
require_relative 'lib/confirmation_sender'
require_relative 'lib/message_sender'

ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

module TwoFactorAuth
  class App < Sinatra::Base
    register Sinatra::ConfigFile
    config_file 'config/app.yml'
    DataMapperHelper.setup(settings.database_url)

    enable :sessions
    set :root, File.dirname(__FILE__)

    helpers Helpers::Authentication

    register Routes::Users
    register Routes::Confirmations
    register Routes::Protected

    get '/' do
      ''
    end
  end
end
