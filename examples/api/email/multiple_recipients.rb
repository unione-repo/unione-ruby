require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  api_key: ENV['UNIONE_API_KEY']
)

# Send email with multiple recipients
message = {}

message[:subject] = 'Subject'

message[:from_email] = 'test@qadns.net'
message[:from_name] = 'userName'

message[:body] = { html: '<b>Hello {{substitutionName}}</b>' }

message[:recipients] = []
message[:recipients] << { email: 'recipient1@example.com' }
message[:recipients] << { email: 'recipient2@example.com' }

response = unione.send_email(message: message)
