module AuthHelpers
  def auth_headers_for(user)
    user.create_new_auth_token.merge('Accept' => 'application/json')
  end

  def json
    response.parsed_body
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :request
end
