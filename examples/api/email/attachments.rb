require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  lang: 'en',
  api_key: ENV['UNIONE_API_KEY']
)

# Send email with attachments
message = {}

message[:subject] = 'Subject'

message[:from_email] = 'test@qadns.net'
message[:from_name] = 'userName'

message[:body] = { html: '<b>Hello {{substitutionName}}</b>' }

message[:recipients] = []
message[:recipients] << { email: 'recipient@example.com' }

message[:attachments] = []
message[:attachments] << { type: 'text/plain', name: 'myfile.txt', content: 'ZXhhbXBsZSBmaWxl' }
message[:inline_attachments] = []
message[:inline_attachments] << { type: 'image/png', name: 'IMAGECID', content: 'iVBORw0KGgo' }

response = unione.send_email(message: message)
