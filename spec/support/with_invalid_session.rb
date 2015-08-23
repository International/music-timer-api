shared_examples 'with invalid session' do
  let(:session_token) { 'INVALID' }
  specify 'is unauthorized' do
    subject
    expect( response.status ).to eq 403
    expect( response.body ).to be_blank
  end
end
