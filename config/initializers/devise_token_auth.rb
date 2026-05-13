# frozen_string_literal: true

DeviseTokenAuth.setup do |config|
  # Clients keep one token per sign-in instead of rotating it on every request.
  config.change_headers_on_each_request = false

  # Bcrypt cost for token hashes; 4 keeps the test suite fast.
  config.token_cost = Rails.env.test? ? 4 : 10

  # This is an API-only app with no session store. bypass_sign_in writes the
  # user into the session, which Rails 7+ rejects; sign_in(store: false) does not.
  config.bypass_sign_in = false
end
