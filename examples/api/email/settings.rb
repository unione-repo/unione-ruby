require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  api_key: ENV['UNIONE_API_KEY']
)

message = {}

message[:subject] = 'Subject'

message[:from_email] = 'test@qadns.net'
message[:from_name] = 'userName'

message[:body] = { plaintext: 'Hello' }

message[:recipients] = []
message[:recipients] << { email: 'recipient@example.com' }

message[:global_metadata] = { key: 'val' }
message[:headers] = { 'X-ReplyTo' => 'reply@qadns.net' }

message[:track_links] = 1
message[:track_read] = 1

# Should have permissions to use this option
message[:skip_unsubscribe] = 1

# Language of the unsubscribe footer and unsubscribe page
message[:global_language] = 'en'

message[:options] = {
  unsubscribe_url: 'https://domain.com/unsubscribe',
  send_at: Time.now, # Or String: '2021-11-19 10:00:00'
  custom_backend_id: 1, # Need permission
  smtp_pool_id: 1       # Need permission
}

response = unione.send_email(message: message)
