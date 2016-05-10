require_relative '../spec_helper'

describe 'Routes::Sessions' do
  describe 'GET /sessions/new' do
    it 'is successful' do
      get '/sessions/new'
      expect(last_response).to be_ok
    end
  end

  describe 'POST /sessions' do
    let!(:user) do
      User.create(first_name:   'Bob',
                  last_name:    'Doe',
                  email:        'bob@example.com',
                  phone_number: '555-555',
                  password:     's3cr37')
    end

    context "when credentials are correct" do
      before do
        allow(ConfirmationSender).to receive(:send_confirmation_to)
        post '/sessions', { email: 'bob@example.com', password: 's3cr37' }
      end

      it 'adds :user_id to session' do
        expect(last_request.env['rack.session']['user_id']).to eq(user.id)
      end

      it 'redirect to confirmation page' do
        expect(last_response).to be_redirect
        expect(last_response.location).to include '/confirmations/new'
      end

      it 'sends a confirmation message to the user' do
        expect(ConfirmationSender)
          .to have_received(:send_confirmation_to)
          .with(user)
          .once
      end
    end

    context "when credentials are incorrect" do
      before do
        allow(ConfirmationSender).to receive(:send_confirmation_to)
        post '/sessions', { email: 'bob@example.com', password: 'secret' }
      end

      it 'does not add :user_id to session' do
        expect(last_request.env['rack.session']['user_id']).to be_nil
      end

      it 'is successful' do
        expect(last_response).to be_ok
      end
    end
  end
end
