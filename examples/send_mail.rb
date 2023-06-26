require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  lang: 'en',
  api_key: ENV['UNIONE_API_KEY'],
  enable_logging: true
)

message = {}

message[:template_engine] = 'simple'
message[:template_id] = 'template_id'

# In case template_id is not specified, subject and body are mandatory
message[:subject] = 'test letter'
message[:body] = {"html": "tests", "plaintext": "plaintext"}

message[:from_email] = 'test@qadns.net'
message[:from_name] = 'userName'

message[:recipients] = []
message[:recipients] << {
  email: 'test1@example.com',
  substitutions: { 'substitutionName' => 'substitutionVal', to_name: 'Name Surname' },
  metadata: { key1: 'val' },
}

message[:global_metadata] = { key1: 'val' }
message[:headers] = { 'X-ReplyTo' => 'reply@example.com' }
message[:options] = { unsubscribe_url: 'someurl' }

message[:attachments] = []
message[:attachments] << { type: 'text/plain', name: 'myfile.txt', content: 'ZXhhbXBsZSBmaWxl' }

message[:inline_attachments] = []
message[:inline_attachments] << { type: 'image/png', name: 'IMAGECID', content: 'iVBORw0KGgo' }

response = unione.send_email(message: message)

puts response.status
puts response.body.to_h
puts response.headers
