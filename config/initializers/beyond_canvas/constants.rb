# frozen_string_literal: true

if BeyondCanvas.configuration.cockpit_app == true && !Rails.env.development?
  puts 'INSIDE SECURE NONE'
  COOKIES_ATTRIBUTES = {
    expires: 1.year.from_now,
    same_site: :none,
    secure: true
  }.freeze
else
  puts 'OUTSIDE SECURE NONE'
  COOKIES_ATTRIBUTES = {
    expires: 1.year.from_now
  }.freeze
end
