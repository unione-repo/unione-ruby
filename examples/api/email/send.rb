require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  lang: 'en',
  api_key: ENV['UNIONE_API_KEY']
)

message = {}

message[:subject] = 'Subject'

message[:from_email] = 'test@qadns.net'
message[:from_name] = 'userName'

message[:body] = { plaintext: 'Hello' }

# HTML body
message[:body] = { html: '<b>Hello {{substitutionName}}</b>' }

message[:recipients] = []
message[:recipients] << { email: 'recipient@example.com' }

response = unione.send_email(message: message)
