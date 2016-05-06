require_relative '../spec_helper'

describe ConfirmationSender do
  describe '.send_confirmation_to' do
    let(:user) do
      User.create(first_name:   'Alice',
                  last_name:    'Doe',
                  email:        'alice@example.com',
                  phone_number: '555-555',
                  password:     's3cr37')
    end
    let(:verification_code) { '219023' }

    before do
      allow(CodeGenerator).to receive(:generate) { verification_code }
      allow(MessageSender).to receive(:send_code)
        .with(user.phone_number, verification_code )
      described_class.send_confirmation_to(user)
    end

    it 'generates a code' do
      expect(CodeGenerator).to have_received(:generate).once
    end

    it 'updates the verification code' do
      expect(user.verification_code).to eq(verification_code)
    end

    it 'sends the generated code' do
      expect(MessageSender).to have_received(:send_code)
        .with(user.phone_number, verification_code).once
    end
  end
end
