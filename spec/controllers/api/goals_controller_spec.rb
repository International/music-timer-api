require 'rails_helper'

RSpec.describe Api::GoalsController, type: :controller do
  include_context 'with session'
  let(:piece) { create_test_piece( user: user ) }
  let(:goal) { create_test_goal( piece: piece, user: user ) }
  let(:model_class) { Goal }
  let(:params) {
    {
      time_unit: 1, unit_value: 23.2, piece_id: piece.id
    }
  }
  shared_examples 'with invalid parameters' do
    let(:params) {
      {
        time_unit: 'seconds', unit_value: '-', piece_id: 32
      }
    }
    it_behaves_like 'post fail'
  end
  describe '#create' do
    subject do
      post :create, params
    end
    it_behaves_like 'member success'
    it_behaves_like 'with invalid parameters'
    it_behaves_like 'with invalid session'
  end
  describe '#update' do
    let(:other_piece) { create_test_piece( user: user ) }
    let(:params) {
      {
        time_unit: 3, unit_value: 5.2, piece_id: other_piece.id
      }
    }
    subject do
      put :update, params.merge(id: goal.id)
    end
    it_behaves_like 'member success'
    it_behaves_like 'with invalid parameters'
    it_behaves_like 'with invalid session'
  end
  describe '#show' do
    subject do
      get :show, id: goal.id
    end
    context 'not found' do
      subject do
        get :show, id: -1
      end
      it_behaves_like 'member not found'
    end
    it_behaves_like 'member success'
    it_behaves_like 'with invalid session'
  end

end
