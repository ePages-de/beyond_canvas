module BeyondCanvas
  module Middleware
    class CockpitAppHeader
      def initialize(app)
        @app = app
      end

      def call(env)
        puts '~' * 75
        puts 'INSIDE MIDDLEWARE'
        puts '~' * 75
        status, headers, response = @app.call(env)
        headers['X-Frame-Options'] = 'ALLOWALL'
        [status, headers, response]
      end
    end
  end
end
