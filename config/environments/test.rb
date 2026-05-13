Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = false

  config.public_file_server.headers = { 'cache-control' => 'public, max-age=3600' }

  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store
  config.action_dispatch.show_exceptions = :rescuable
  config.action_controller.allow_forgery_protection = false

  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = { host: 'www.example.com' }

  config.active_support.deprecation = :stderr
  config.action_controller.raise_on_missing_callback_actions = true

  # Fail any request spec that triggers an N+1 query or an unused eager load.
  config.after_initialize do
    Bullet.enable = true
    Bullet.raise = true
  end
end
