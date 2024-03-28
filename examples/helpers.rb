require 'unione-ruby'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  api_key: ENV['UNIONE_API_KEY']
)

# Verify webhook callback message
# Will raise Unione::Client::InvalidCallbackAuth error unless `auth' field is correct.
unione.verify_callback_auth!(params)

# Callback helper usage
# Will raise Unione::Client::InvalidCallbackAuth error unless `auth' field is correct.
unione.callback_helper(params) do |events|
  # [
  #   {
  #     'event_name' => 'transactional_email_status',
  #     'event_data' =>
  #      {
  #        'email' => 'recipient.email@example.com',
  #        'status' => 'sent',
  #        'event_time' => '2015-11-30 15:09:42',
  #       ...
  #      }
  #   },
  #   ...
  # ]
end
