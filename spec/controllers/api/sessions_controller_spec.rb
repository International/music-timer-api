require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  describe '#create' do
    subject do
      post :create, params
    end

    context 'by credentials' do
      context 'with valid credentials' do
        context 'by email' do
          let(:password) { 'Melfian232' }
          let(:user) {
            create_test_user password: password, password_confirmation: password
          }
          let(:params) {
            { email: user.email, password: password }
          }
          it 'creates a valid session' do
            subject
            expect( response.status ).to eq 201
            expect( Session.find_by_id( response_json[:id].to_i ) )
              .not_to be_blank
          end
        end
      end
      context 'without invalid credentials' do
        let(:params) {
          { email: 'test@wqdw.com', password: 'king' }
        }
        it 'is unauthorized' do
          subject
          expect( response.status ).to eq 401
          expect( response.body ).to be_blank
        end
      end
    end

    context 'by facebook' do
      context 'by facebook' do
        let(:user) {
          create_test_facebook_user
        }
        let(:params) {
          { facebook_id: user.facebook_id, mode: 'facebook' }
        }
        it 'creates a valid session' do
          subject
          expect( response.status ).to eq 201
          expect( Session.find_by_id( response_json[:id].to_i ) )
            .not_to be_blank
        end
      end
      context 'without invalid id' do
        let(:params) {
          { facebook_id: 'invalid', mode: 'facebook' }
        }
        it 'is unauthorized' do
          subject
          expect( response.status ).to eq 401
          expect( response.body ).to be_blank
        end
      end
    end

  end
end
