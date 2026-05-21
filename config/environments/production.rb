require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }
  config.active_storage.service = :cloudinary
  config.log_tags = [ :request_id ]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.silence_healthcheck_path = "/up"
  config.active_support.report_deprecations = false
  config.i18n.fallbacks = true
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [ :id ]

  # Action Mailer
  config.action_mailer.default_url_options = { host: "feelog.onrender.com", protocol: "https" }
  config.action_mailer.delivery_method = :sendgrid_actionmailer
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.sendgrid_actionmailer_settings = {
    api_key: ENV['SENDGRID_API_KEY'],
    raise_delivery_errors: true
  }
end