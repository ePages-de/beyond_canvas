# frozen_string_literal: true

module BeyondCanvas
  module RequestValidation # :nodoc:
    extend ActiveSupport::Concern

    private

    def validate_app_installation_request!
      bad_request unless app_installation_params? && valid_signature?(params[:signature],
                                                                      app_installation_data,
                                                                      BeyondApi.configuration.client_secret)
    end

    def app_installation_params?
      if params[:code].nil? ||
         params[:signature].nil? ||
         params[:return_url].nil? ||
         params[:api_url].nil? ||
         params[:access_token_url].nil?
        false
      else
        true
      end
    end

    def app_installation_data
      "#{params[:code]}:#{params[:access_token_url]}"
    end

    def valid_signature?(signature, data, secret)
      digest = OpenSSL::Digest.new('SHA1')
      hmac = OpenSSL::HMAC.digest(digest, secret, data)
      puts '-' * 75
      puts "Signature:  #{signature}"
      puts "Validation: #{Base64.encode64(hmac).chop}"
      puts "CGI valid:  #{CGI.unescape(signature)}"
      puts "CGI.unescape(signature) == Base64.encode64(hmac).chop #{CGI.unescape(signature.gsub(' ', '+')) == Base64.encode64(hmac).chop}"
      puts "CGI.encode(CGI.unescape(signature)) #{CGI.encode(CGI.unescape(signature)) == CGI.encode(Base64.encode64(hmac).chop)}"
      puts '-' * 75

      CGI.unescape(signature).gsub(' ', '+') == Base64.encode64(hmac).chop
    end

    def signature_params
      data = URI.parse(request.original_url).to_s
      data << ":#{request.body.read}" if request.body.read.present?
      data
    end
  end
end
