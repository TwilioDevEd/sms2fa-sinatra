require 'data_mapper'

require_relative '../models/user'

module DataMapperHelper
  def self.setup(database_url)
    DataMapper.setup(:default, database_url)
    DataMapper.finalize

    # Create the user table automatically.
    User.auto_upgrade!
  end
end
