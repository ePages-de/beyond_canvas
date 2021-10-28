module BeyondCanvas
  module Middleware
    class CockpitAppHeader
      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, response = @app.call(env)
        request = ActionDispatch::Request.new env

        if request.headers['Sec-Fetch-Dest'] == 'iframe'
          headers['Content-Security-Policy'] = <<~POLICY.gsub "\n", ' '
            frame-ancestors #{request.session[:iframe_ancestor_url]} #{request.referer};
          POLICY
        end

        [status, headers, response]
      end
    end
  end
end
