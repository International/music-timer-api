shared_examples 'post fail' do
  specify 'fails posting' do
    set_auth_token session_token
    subject
    expect( response.status ).to eq 422
    expect( response_json[:errors] ).not_to be_blank
  end
end
