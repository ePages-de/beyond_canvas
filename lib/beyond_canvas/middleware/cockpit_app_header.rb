module BeyondCanvas
  module Middleware
    class CockpitAppHeader
      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, response = @app.call(env)
        request = ActionDispatch::Request.new env
        sec_fetch_dest = request.headers['Sec-Fetch-Dest']

        if sec_fetch_dest == 'iframe' || (request.user_agent.match?(/Safari/) && sec_fetch_dest.blank?)
          headers['Content-Security-Policy'] = <<~POLICY.gsub "\n", ' '
            frame-ancestors #{request.session[:iframe_ancestor_url]} #{request.referer};
          POLICY

          if sec_fetch_dest.blank?
            headers['X-Frame-Options'] = 'ALLOWALL'
            puts '_' * 100
            puts request.user_agent
            puts '_' * 100
          end
        end

        [status, headers, response]
      end
    end
  end
end
