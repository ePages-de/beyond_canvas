module BeyondCanvas
  module Middleware
    class CockpitAppHeader
      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, response = @app.call(env)
        request = ActionDispatch::Request.new env

        puts '-' * 75
        puts headers
        puts '-' * 75

        headers['X-Frame-Options'] = 'ALLOWALL'

        unless headers['User-Agent'].match(/Chrome/)
          puts '*' * 75
          puts 'NO CHROME'
          puts '*' * 75
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS, PATCH, DELETE'
          headers['Access-Control-Request-Method'] = '*'
          headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, X-Frame-Options, X-CSRF-Token'
        end

        [status, headers, response]
      end
    end
  end
end
