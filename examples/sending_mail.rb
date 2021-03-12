require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])

mail = UniOne::Mail.new

template_id    = "bc0372d4-69f2-11eb-9d14-366b3a36c9e1"
mail.template  = { template_engine: 'simple', template_id: template_id }

mail.from      = { from_email: 'test@qadns.net', from_name: 'userName' }

substitutions  = { 'substitutionName' => 'substitutionVal', to_name: 'Name Surname 1' }
recipient      = { email: 'test1@example.com', substitutions: substitutions, metadata: { key1: 'val1' } }
mail.recipients << recipient

substitutions  = { 'substitutionName' => 'substitutionVal', to_name: 'Name Surname 2' }
recipient      = { email: 'test2@example.com', substitutions: substitutions, metadata: { key1: 'val1' } }
mail.recipients << recipient

mail.global_metadata  = { key1: 'val1' }
mail.headers   = { 'X-ReplyTo' => 'reply@example.com' }
mail.options   = { unsubscribe_url: 'someurl' }

mail.attachments        << { type: 'text/plain', name: 'myfile.txt', content: 'ZXhhbXBsZSBmaWxl' }
mail.inline_attachments << { type: 'image/png', name: 'IMAGECID', content: 'iVBORw0KGgo' }

response = unione.send_email(mail.to_json)

puts response.status
puts response.body.to_h
puts response.headers
