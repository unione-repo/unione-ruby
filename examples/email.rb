require_relative '../../../lib/unione-ruby'
require 'json'

# Send email
mail = UniOne::Mail.new
mail.body = {html: "<b>Hello {{substitutionName}}</b>"}
mail.from = {from_email: 'test@example.com', from_name: 'userName'}
mail.subject = 'Email Subject'
mail.template = {"template_engine" => "simple", "template_id" => "template_id"}

substitutions = {"substitutionName" => "substitutionVal", "to_name" => "Name Surname"}
recipient = {email: 'test@example.com', substitutions: substitutions, metadata: {"key1" => "val1"}}
mail.recipients << recipient

mail.metadata = {"key1" => "val1"}
mail.headers = {"X-ReplyTo" => "reply@example.com"}
mail.attachments << {"type" => "text/plain", "name" => "myfile.txt", "content" => "ZXhhbXBsZSBmaWxl"}
mail.inline_attachments << {"type" => "image/png", "name" => "IMAGECID", "content" => "iVBORw0KGgo"}
mail.options = {"unsubscribe_url" => "someurl"}

puts mail.to_json

unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])
response = unione.send_email(mail.to_json)
puts response.status
puts response.body
puts response.headers

# Subscribe email
unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])
response = unione.subscribe_email(email_address_from: "emailFrom",
  email_address_to: "blackhole@example.com", name_from: "Example Sender")
