require_relative '../spec_helper'

describe 'Routes::Users' do
  let(:user) do
    User.create(first_name:        'Bob',
                last_name:         'Doe',
                email:             'bob@example.com',
                phone_number:      '555-555',
                password:          's3cr37',
                verification_code: '123456')
  end

  describe 'GET /confirmations/new' do
    it 'is successful' do
      get '/confirmations/new', {}, 'rack.session' => { user_id: user.id }
      expect(last_response).to be_ok
    end
  end

  describe 'POST /confirmations' do
    before do
      post '/confirmations', { user_id: user.id, verification_code: '123456' }
    end

    context 'when verification code is correct' do
      it 'updates confirmed to true' do
        user.reload
        expect(user.confirmed).to be_truthy
      end

      it 'authenticates the user' do
        expect(last_request.env['rack.session']['authenticated']).to be_truthy
      end

      it 'redirects to /' do
        expect(last_response).to be_redirect
        expect(last_response.location).to include '/protected'
      end
    end

    context 'when verification code is incorrect' do
      before do
        post '/confirmations', { user_id: user.id, verification_code: '112233' }
      end

      it 'does not change confirmed' do
        expect(user.confirmed).to be_falsey
      end

      it 'renders confirmation template' do
        expect(last_response).to be_ok
      end
    end
  end
end
