require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:params) {
    {
      user: {
        email: 'test1232@gmail.com',
        password: 'Test_123',
        first_name: 'John',
        last_name: 'Doe',
        country: 'US',
        state: 'Washington',
        city: 'Bothell'
      }
    }
  }
  describe '#create' do
    subject do
      post :create, params
    end
    it 'creates a user' do
      subject
      expect( response ).to be_success
      expect( User.find_by_id( response_json[:id].to_i ) ).not_to be_blank
    end
  end
end
