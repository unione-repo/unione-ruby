module UniOne
  class Client

    module Unsubscribed

      def unsubscribe(address)
        params = { address: address }
        post 'unsubscribed/set.json', params
        validate_response({
          'type' => 'object', 'required' => ['status', 'address', 'message'], 'properties' => {
            'status' => {'type' => 'string'},
            'address' => {'type' => 'string'},
            'message' => {'type' => 'string'}}
        })
      end

      def check_unsubscribed(address)
        params = { address: address }
        post 'unsubscribed/check.json', params
        validate_response({
          'type' => 'object', 'required' => ['status', 'address', 'is_unsubscribed'], 'properties' => {
            'status' => {'type' => 'string'},
            'address' => {'type' => 'string'},
            'is_unsubscribed' => {'type' => 'boolean'}}
        })
      end

      def list_unsubscribed(date_from)
        params = { date_from: date_from }
        post 'unsubscribed/list.json', params
        validate_response({
          'type' => 'object', 'required' => ['status', 'unsubscribed'], 'properties' => {
            'status' => {'type' => 'string'},
            'unsubscribed' => {
              'items' => {'type' => 'object'}, 'required' => ['address', 'unsubscribed_on'], 'properties' => {
                'address' => {'type' => 'string'},
                'unsubscribed_on' => {'type' => 'string'}
              }}}
        })
      end

    end
  end
end
