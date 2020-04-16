# frozen_string_literal: true

# Filter app installation parameters
Rails.application.config.filter_parameters += [
  :access_token_url,
  :code,
  :return_url,
  :signature
]
