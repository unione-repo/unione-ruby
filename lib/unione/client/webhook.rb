module UniOne
  class Client

    module Webhook

      def set_webhook(webhook)
        post 'webhook/set.json', webhook
        validate_response({'type' => 'object', 'required' => ['status', 'object'], 'properties' => {
           'status' => {'type' => 'string'},
           'object' => webhook_schema
         }})
      end

      def get_webhook(url)
        params = { url: url }
        post 'webhook/get.json', params
        get_webhook_schema = remove_fields_from_schema(webhook_schema, ['delivery_info', 'single_event'])
        validate_response({'type' => 'object', 'required' => ['status', 'object'], 'properties' => {
           'status' => {'type' => 'string'},
           'object' => get_webhook_schema
         }})
      end

      def delete_webhook(url)
        params = { url: url }
        post 'webhook/delete.json', params
        validate_response({'type' => 'object', 'required' => ['status'], 'properties' => {
           'status' => {'type' => 'string'}
         }})
      end

      private

      def webhook_schema
        {'type' => 'object', 'required' => ['url', 'events', 'event_format', 'delivery_info', 'single_event', 'max_parallel'], 'properties' => {
           'url' => {'type' => 'string'},
           'events' => webhook_events_schema,
           'event_format' => {'type' => 'string'},
           'delivery_info' => {'type' => 'integer'},
           'single_event' => {'type' => 'integer'},
           'max_parallel' => {'type' => 'integer'}
         }}
      end

      def webhook_events_schema
        {'type' => 'object', 'required' => ['email_status', 'spam_block'], 'properties' => {
           'email_status' => {'items' => {'type' => 'string'}},
           'spam_block' => {'items' => {'type' => 'string'}}
         }}
      end
    end
  end
end
