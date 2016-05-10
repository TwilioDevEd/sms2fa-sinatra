require_relative '../spec_helper'

describe 'Routes::Protected' do
  describe 'GET /protected' do
    context 'when user is authenticated' do
      it 'is successful' do
        get '/protected', {}, 'rack.session' => { authenticated: 'true' }
        expect(last_response).to be_ok
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to /' do
        get '/protected'
        expect(last_response).to be_redirect
        expect(last_response.location).to include '/'
      end
    end
  end
end
