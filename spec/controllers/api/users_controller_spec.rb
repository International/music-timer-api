require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  include_context 'with session'
  let(:params) {
    {
      email: 'test1232@gmail.com',
      password: 'Test_123',
      password_confirmation: 'Test_123',
      first_name: 'John',
      last_name: 'Doe',
      country: 'US',
      state: 'Washington',
      city: 'Bothell'
    }
  }
  shared_examples 'with invalid parameters' do
    let(:params) {
      {
        email: 'paksi',
        password: 'm'
      }
    }
    specify 'is unprocessable' do
      set_auth_token session_token
      subject
      expect( response.status ).to eq 422
      expect( response_json[:errors] ).not_to be_blank
    end
  end
  describe '#create' do
    let(:session_token) { nil }
    subject do
      post :create, params
    end
    context 'by signup' do
      it 'creates a user' do
        subject
        expect( response ).to be_success
        expect( User.find_by_id( response_json[:id].to_i ) ).not_to be_blank
      end
    end
    context 'by facebook' do
      let(:params) {
        {
          facebook_id: 3232
        }
      }
      it 'creates a user' do
        subject
        expect( response ).to be_success
        expect( User.find_by_id( response_json[:id].to_i ) ).not_to be_blank
      end
    end
    it_behaves_like 'with invalid parameters'
  end
  describe '#update' do
    let(:params) {
      {
        email: 'test1232@gmail.com',
        password: 'Test_123',
        password_confirmation: 'Test_123',
        first_name: 'John',
        last_name: 'Doe',
        country: 'US',
        state: 'Washington',
        city: 'Bothell'
      }
    }
    subject do
      put :update, params.merge(id: user.id)
    end
    context 'with password' do
      it 'updates a user' do
        set_auth_token session_token
        subject
        expect( response ).to be_success
        expect( User.find_by_id( response_json[:id].to_i ) ).not_to be_blank
      end
    end
    context 'without password' do
      let(:params) {
        {
          email: 'test1232@gmail.com',
          first_name: 'John',
          last_name: 'Doe',
          country: 'US',
          state: 'Washington',
          city: 'Bothell'
        }
      }
      it 'updates a user' do
        set_auth_token session_token
        subject
        expect( response ).to be_success
        expect( User.find_by_id( response_json[:id].to_i ) ).not_to be_blank
      end
    end
    it_behaves_like 'with invalid parameters'
    it_behaves_like 'with invalid session'
  end
  describe '#show' do
    context 'by default' do
      subject do
        get :show, id: user.id
      end
      it 'returns existing user' do
        set_auth_token session_token
        subject
        expect( response ).to be_success
        expect( User.find_by_id( response_json[:id].to_i ) ).not_to be_blank
      end
      it_behaves_like 'with invalid session'
    end
    context 'by details' do
      before do
        piece_1 = create_test_piece( user: user )
        piece_2 = create_test_piece( user: user )
        goal = create_test_goal( user: user, piece: piece_1 )
        create_test_practice( piece: piece_1 )
        create_test_practice( piece: piece_2 )
      end
      subject do
        get :show, id: user.id, mode: 'details'
      end
      it 'returns existing user' do
        set_auth_token session_token
        subject
        expect( response ).to be_success
        expect( User.find_by_id( response_json[:id].to_i ) ).not_to be_blank
      end
      it_behaves_like 'with invalid session'
    end
  end

end
