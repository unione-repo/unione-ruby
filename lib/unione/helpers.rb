require 'digest'

module UniOne
  class Client
    module Helpers
      # Helper function for webhooks callback. It is checking auth field
      # and if it is invalid, raises Unione::Client::InvalidCallbackAuth exception
      def verify_callback_auth!(params)
        params = params.transform_keys(&:to_sym)
        auth = params[:auth]
        unless auth == Digest::MD5.hexdigest(params.merge(auth: @api_key).to_json)
          raise InvalidCallbackAuth
        end
      end

      def callback_helper(params)
        verify_callback_auth!(params)
        yield params.dig('events_by_user', 0, 'events')
      end
    end
  end
end
