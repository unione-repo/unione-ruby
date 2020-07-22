require 'unione-ruby'
require 'json'

# Set template
template = UniOne::Template.new
template.name = 'Template Name'
template.subject = 'Email Subject'
template.template_engine = 'simple'
template.global_substitutions = {"someVar" => "someVal"}

template.from = {from_email: 'test@example.com', from_name: 'userName'}
template.headers = {"X-ReplyTo" => "reply@example.com"}
template.body = {html: "<b>Hello {{substitutionName}}</b>"}

template.attachments << {"type" => "text/plain", "name" => "myfile.txt", "content" => "ZXhhbXBsZSBmaWxl"}
template.inline_attachments << {"type" => "image/png", "name" => "IMAGECID", "content" => "iVBORw0KGgo"}
template.options = {"unsubscribe_url" => "someurl"}

puts template.to_json

unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])
response = unione.set_template(template.to_json)
puts response.status
puts response.body.to_h
puts response.body.template.id   # Get Id of created template for later referencing
puts response.headers

# Get template
unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])
response = unione.get_template("cef89054-40a8-4b9b-a379-22030d525c49")

# List templates
response = unione.list_templates(50, 0)

# Delete template
response = unione.delete_template("cef89054-40a8-4b9b-a379-22030d525c49")
