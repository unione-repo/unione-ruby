require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  lang: 'en',
  api_key: ENV['UNIONE_API_KEY']
)

# Send email using template
message = {}

message[:subject] = 'Subject'

message[:from_email] = 'test@qadns.net'
message[:from_name] = 'userName'

message[:recipients] = []
message[:recipients] << { email: 'recipient@example.com' }

message[:template_engine] = 'simple'
message[:template_id] = 'template_id'

message[:tags] = ['string1']

response = unione.send_email(message: message)
