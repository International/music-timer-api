require 'rails_helper'

RSpec.describe Api::PiecesController, type: :controller do
  include_context 'with session'
  let(:piece) { create_test_piece( user: user ) }
  let(:model_class) { Piece }
  let(:params) {
    {
      title: 'Beethoven', description: 'Practicing Beethoven'
    }
  }
  shared_examples 'with invalid parameters' do
    let(:params) {
      {
        description: ''
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
    let(:params) {
      {
        title: 'Bach 2', description: 'Practicing Bach'
      }
    }
    subject do
      put :update, params.merge(id: piece.id)
    end
    it_behaves_like 'member success'
    it_behaves_like 'with invalid parameters'
    it_behaves_like 'with invalid session'
  end
  describe '#show' do
    subject do
      get :show, id: piece.id
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
