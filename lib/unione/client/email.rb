module UniOne
  class Client

    module Email

      def send_email(message)
        post 'email/send.json', message
        validate_response({
          'type' => 'object', 'required' => ['status', 'job_id', 'emails'], 'properties' => {
            'status' => {'type' => 'string'},
            'job_id' => {'type' => 'string'},
            'emails' => {'items' => {'type' => 'string'}},
            'failed_emails' => {'type' => 'object'}}
        })
      end

      def subscribe_email(email_address_from:, email_address_to:, name_from:)
        params = {
          email_address_from: email_address_from,
          email_address_to: email_address_to,
          name_from: name_from
        }
        post 'email/subscribe.json', params
        validate_response({
          'type' => 'object', 'required' => ['status'], 'properties' => {
            'status' => {'type' => 'string'}}
        })
      end

    end
  end
end
