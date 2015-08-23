shared_examples 'member not found' do
  specify 'is not found' do
    set_auth_token session_token
    subject
    expect( response.status ).to eq 404
    expect( response.body ).to be_blank
  end
end
