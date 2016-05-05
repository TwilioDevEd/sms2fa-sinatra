require 'sinatra/base'
require 'sinatra/config_file'
require 'tilt/haml'

require_relative 'helpers/datamapper_helper'
require_relative 'routes/users'

ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

module TwoFactorAuth
  class App < Sinatra::Base
    register Sinatra::ConfigFile
    config_file 'config/app.yml'
    DataMapperHelper.setup(settings.database_url)
    set :root, File.dirname(__FILE__)

    register Routes::Users

    get '/' do
      ''
    end
  end
end
