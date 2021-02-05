# frozen_string_literal: true

if BeyondCanvas.configuration.cockpit_app == true && Rails.env.production?
  Rails.application.config.session_store :cookie_store, {
    secure: :true,
    same_site: :none
  }
end
