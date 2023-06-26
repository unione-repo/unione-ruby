require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  lang: 'en',
  api_key: ENV['UNIONE_API_KEY']
)

# Set template
template = {}

template[:name] = 'Template Name 1'
template[:editor_type] = 'html'
template[:subject] = 'Email Subject'
template[:template_engine] = 'simple'

template[:global_substitutions] = {
  'someVar' => 'someVal'
}

template[:from_email] = 'test@example.com'
template[:from_name] = 'userName'

template[:headers] = { 'X-ReplyTo' => 'reply@example.com' }
template[:body] = { html: '<b>Hello {{substitutionName}}</b>' }
template[:options] = { unsubscribe_url: 'someurl' }

template[:attachments] = []
template[:attachments] << { type: 'text/plain', name: 'myfile.txt', content: 'ZXhhbXBsZSBmaWxl' }

template[:inline_attachments] = []
template[:inline_attachments] << { type: 'image/png', name: 'IMAGECID', content: 'iVBORw0KGgo' }

response = unione.set_template(template: template)

# Get id of created template
template_id = response.body.template.id

# Get template
response = unione.get_template(
  id: template_id
)

# List templates
response = unione.list_templates(
  limit: 50,
  offset: 0
)

# Delete template
response = unione.delete_template(
  id: template_id
)
