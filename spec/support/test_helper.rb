def response_json
  JSON.parse( response.body, symbolize_names: true )
end

def set_auth_token( token )
  request.headers['X-Auth-Token'] = token
end

def create_test_user(options = {})
  User.create({email: 'testking@gmail.com', password: 'Test_123',
    password_confirmation: 'Test_123', first_name: 'James', last_name: 'Doe',
    country: 'US', state: 'Washington', city: 'Kirkland'}.merge(options))
end

def create_test_facebook_user(options = {})
  User.create({facebook_id: 32132, first_name: 'James', last_name: 'Doe',
    country: 'US', state: 'Washington', city: 'Kirkland'}.merge(options))
end

def create_test_goal(options = {})
  Goal.create({time_unit: 1, unit_value: 432.32}.merge(options))
end

def create_test_practice(options = {})
  Practice.create({name: 'Today', seconds: 321,
    recorded_at_value: 1440309222306, state: 3 }.merge(options))
end

def create_test_piece(options = {})
  Piece.create({title: 'Mozart',
    description: 'Practicing Mozart'}.merge(options))
end
