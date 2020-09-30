# frozen_string_literal: true

module BeyondCanvas
  module Models
    module Shop # :nodoc:
      extend ActiveSupport::Concern

      include ::BeyondCanvas::Models::Concerns::Authentication
      include ::BeyondCanvas::Models::Concerns::Utils
    end
  end
end
