require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])

# set template
template = UniOne::Template.new

template.name            = 'Template Name'
template.editor_type     = 'html'
template.subject         = 'Email Subject'
template.template_engine = 'simple'

template.global_substitutions = { 'someVar' => 'someVal' }

template.from    = { from_email: 'test@example.com', from_name: 'userName' }
template.headers = { 'X-ReplyTo' => 'reply@example.com' }
template.body    = { html: '<b>Hello {{substitutionName}}</b>' }
template.options = { unsubscribe_url: 'someurl' }

template.attachments        << { type: 'text/plain', name: 'myfile.txt', content: 'ZXhhbXBsZSBmaWxl' }
template.inline_attachments << { type: 'image/png', name: 'IMAGECID', content: 'iVBORw0KGgo' }

puts template.to_json

response = unione.set_template(template.to_json)

puts response.status
puts response.body.to_h
puts response.headers

# get id of created template
template_id = response.body.template.id

# get template
response = unione.get_template(template_id)

# list all templates
response = unione.list_templates(50, 0)

# delete template
response = unione.delete_template(template_id)
