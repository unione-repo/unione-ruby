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

      def list_webhooks(limit, offset)
        params = { limit: limit, offset: offset }
        post 'webhook/list.json', params
        validate_response({
          'type' => 'object', 'required' => ['status', 'objects'], 'properties' => {
            'status' => {'type' => 'string'},
            'objects' =>
            {'items' =>
             {'type' => 'object', 'required' => ['id', 'url', 'status', 'updated_at', 'events', 'event_format', 'delivery_info', 'single_event', 'max_parallel'], 'properties' => [
              'id' => {'type' => 'integer'},
              'url' => {'type' => 'string'},
              'status' => {'type' => 'string'},
              'updated_at' => {'type' => 'string'},
              'events' =>
              {'type' => 'object', 'required' => ['email_status', 'spam_block'], 'properties' => [
               'email_status' => {'items' => {'type' => 'string'}},
               'spam_block' => {'items' => {'type' => 'string'}}]},
              'event_format' => {'type' => 'string'},
              'delivery_info' => {'type' => 'integer'},
              'single_event' => {'type' => 'integer'},
              'max_parallel' => {'type' => 'integer'}
              ]}}}
        })
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
        {'type' => 'object', 'required' => ['url', 'status', 'events', 'event_format', 'delivery_info', 'single_event', 'max_parallel'], 'properties' => {
           'id' => {'type' => 'integer'},
           'url' => {'type' => 'string'},
           'status' => {'type' => 'string'},
           'event_format' => {'type' => 'string'},
           'delivery_info' => {'type' => 'integer'},
           'single_event' => {'type' => 'integer'},
           'max_parallel' => {'type' => 'integer'},
           'events' => webhook_events_schema,
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
