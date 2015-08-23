require 'rails_helper'

RSpec.describe Api::Pieces::PracticesController, type: :controller do
  include_context 'with session'
  let(:piece) { create_test_piece( user: user ) }
  let(:practice) { create_test_practice( piece: piece ) }
  let(:model_class) { Practice }
  let(:params) {
    {
      name: 'Practiced at 1/1/2015', seconds: 21, state: 2,
      recorded_at_value: 1440309222306
    }
  }
  shared_examples 'with invalid parameters' do
    let(:params) {
      {
        name: 'Practiced at 1/1/2015', seconds: 'dwqdw'
      }
    }
    it_behaves_like 'post fail'
  end
  describe '#create' do
    subject do
      post :create, params.merge( piece_id: piece.id )
    end
    it_behaves_like 'member success'
    it_behaves_like 'with invalid parameters'
    it_behaves_like 'with invalid session'
  end
  describe '#update' do
    let(:params) {
      {
        name: 'Practiced at 4/5/2015', seconds: 321, state: 1
      }
    }
    subject do
      put :update, params.merge(id: practice.id, piece_id: piece.id)
    end
    it_behaves_like 'member success'
    it_behaves_like 'with invalid parameters'
    it_behaves_like 'with invalid session'
  end
  describe '#show' do
    subject do
      get :show, id: practice.id, piece_id: piece.id
    end
    context 'not found' do
      subject do
        get :show, id: -1, piece_id: piece.id
      end
      it_behaves_like 'member not found'
    end
    it_behaves_like 'member success'
    it_behaves_like 'with invalid session'
  end
end
