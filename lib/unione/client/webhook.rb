module UniOne
  class Client
    module Webhook
      extend UniOne::Validation::ClassMethods
      include UniOne::Validation::InstanceMethods

      def set_webhook(params = {})
        post('webhook/set.json', params)
      end

      def get_webhook(params = {})
        post('webhook/get.json', params)
      end

      def list_webhooks(params = {})
        post('webhook/list.json', params)
      end

      def delete_webhook(params = {})
        post('webhook/delete.json', params)
      end

      add_response_validations(
        :webhook,
        %w(
          set_webhook
          get_webhook
          list_webhooks
          delete_webhook
        )
      )
    end
  end
end
