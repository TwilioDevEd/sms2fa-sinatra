require_relative '../spec_helper'

describe 'root' do
  describe 'GET /' do
    it 'is successful' do
      get '/'
      expect(last_response).to be_ok
    end
  end
end
