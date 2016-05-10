require 'data_mapper'

class User
  include DataMapper::Resource

  property :id, Serial
  property :first_name,        String,     required: true
  property :last_name,         String,     required: true
  property :email,             String,     required: true
  property :phone_number,      String,     required: true
  property :password,          BCryptHash, required: true
  property :verification_code, String,                     default:  ''
  property :confirmed,         Boolean,                    default:  false

  def pretty_phone_number
    Phony.format(phone_number.gsub(/[\+\-\s]/, ''))
  end
end
