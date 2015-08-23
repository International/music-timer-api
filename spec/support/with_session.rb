shared_context 'with session' do
  let(:session_token) { user.start_session.token }
  let(:user) {
    create_test_user
  }
end
