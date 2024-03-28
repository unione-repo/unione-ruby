require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  api_key: ENV['UNIONE_API_KEY']
)

# Validate domain verification record
unione.validate_verification_record(domain: 'qadns.net')

# Create template
template = {}

template[:name] = 'Template Name'
template[:subject] = 'Email Subject'
template[:template_engine] = 'simple'
template[:headers] = {'X-ReplyTo' => 'reply@example.com'}

template[:global_substitutions] = { 'someVar' => 'someVal' }
template[:from_email] = 'test@example.com'
template[:from_name] = 'userName'
template[:body] = { html: '<b>Hello {{substitutionName}}</b>' }
template[:options] = { unsubscribe_url: 'someurl' }

template[:attachments] = []
template[:attachments] << { type: 'text/plain', name: 'myfile.txt', content: 'ZXhhbXBsZSBmaWxl' }

template[:inline_attachments] = []
template[:inline_attachments] << { type: 'image/png', name: 'IMAGECID', content: 'iVBORw0KGgo' }

response = unione.set_template(template: template)
template_id = response.body.template.id
