require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])

# Validate domain verification record
unione.validate_verification_record('example.com')

# Create template
template = UniOne::Template.new

template.name                 = 'Template Name'
template.subject              = 'Email Subject'
template.template_engine      = 'simple'
template.headers              = { 'X-ReplyTo' => 'reply@example.com' }
template.global_substitutions = { 'someVar' => 'someVal' }

template.from                 = { from_email: 'test@example.com', from_name: 'userName' }
template.body                 = { html: '<b>Hello {{substitutionName}}</b>' }

template.attachments         << { type: 'text/plain', name: 'myfile.txt', content: 'ZXhhbXBsZSBmaWxl' }
template.inline_attachments  << { type: 'image/png', name: 'IMAGECID', content: 'iVBORw0KGgo' }

template.options              = { unsubscribe_url: 'someurl' }

response = unione.set_template(template.to_json)
template_id = response.body.template.id
