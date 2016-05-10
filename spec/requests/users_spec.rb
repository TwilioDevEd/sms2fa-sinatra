require_relative '../spec_helper'

describe 'Routes::Users' do
  describe 'GET /users/new' do
    it 'is successful' do
      get '/users/new'
      expect(last_response).to be_ok
    end
  end

  describe 'POST /users' do
    context "when the information is complete" do
      before do
        attributes_for_user = {
          first_name:   'Bob',
          last_name:    'Doe',
          email:        'bob@example.com',
          phone_number: '555-555',
          password:     's3cr37'
        }

        allow(ConfirmationSender).to receive(:send_confirmation_to)
        post '/users', attributes_for_user
      end

      it 'creates a user' do
        bob = User.last
        expect(bob.email).to eq 'bob@example.com'
      end

      it 'redirect to confirmation page' do
        expect(last_response).to be_redirect
        expect(last_response.location).to include '/'
      end

      it 'sends a confirmation message to the user' do
        bob = User.last
        expect(ConfirmationSender)
          .to have_received(:send_confirmation_to)
          .with(bob)
          .once
      end
    end

    context "when the information is incomplete" do
      before do
        attributes_for_user = { first_name: 'Bob' }
        post '/users', attributes_for_user
      end

      it 'does not create a user' do
        bob = User.last
        expect(bob).to be_nil
      end

      it 'is successful' do
        expect(last_response).to be_ok
      end
    end
  end
end
