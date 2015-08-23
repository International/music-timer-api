shared_examples 'member success' do
  specify 'extracts a member object' do
    set_auth_token session_token
    subject
    expect( response ).to be_success
    expect( model_class.find_by_id( response_json[:id].to_i ) ).not_to be_blank
  end
end
