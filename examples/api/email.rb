require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])

# sending mail
mail = UniOne::Mail.new

mail.subject  = 'Email Subject'
mail.from     = { from_email: 'test@qadns.net', from_name: 'userName' }

# Using body
mail.body     = { html: '<b>Hello {{substitutionName}}</b>' }

# Using template
# mail.template = { template_engine: 'simple', template_id: 'template_id' }

substitutions = { 'substitutionName' => 'substitutionVal', to_name: 'Name Surname 1' }
recipient1    = { email: 'test1@example.com', substitutions: substitutions, metadata: { key1: 'val1' } }
mail.recipients << recipient1

substitutions = { 'substitutionName' => 'substitutionVal', to_name: 'Name Surname 2' }
recipient2    = { email: 'test2@example.com', substitutions: substitutions, metadata: { key1: 'val1' } }
mail.recipients << recipient2

mail.global_metadata = { key1: 'val1' }
mail.headers = { 'X-ReplyTo' => 'reply@qadns.net' }
mail.track   = { track_links: 1, track_read: 1 }
mail.options = { unsubscribe_url: 'someurl' }

# Should have rights to use this option
# mail.skip_unsubscribe = 1
mail.force_send       = 0

mail.attachments        << { type: 'text/plain', name: 'myfile.txt', content: 'ZXhhbXBsZSBmaWxl' }
mail.inline_attachments << { type: 'image/png', name: 'IMAGECID', content: 'iVBORw0KGgo' }

puts mail.to_json

response = unione.send_email(mail.to_json)

puts response.status
puts response.body
puts response.headers

# subscribe email
response = unione.subscribe_email(
  from_email: 'from@qadns.net',
  from_name: 'Example Sender',
  to_email: 'blackhole@example.com'
)
