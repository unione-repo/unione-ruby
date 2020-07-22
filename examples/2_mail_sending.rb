require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])

mail = UniOne::Mail.new
mail.template = {"template_engine" => "simple", "template_id" => template_id}

substitutions = {"substitutionName" => "substitutionVal", "to_name" => "Name Surname 1"}
recipient = {email: 'test1@example.com', substitutions: substitutions, metadata: {"key1" => "val1"}}
mail.recipients << recipient

substitutions = {"substitutionName" => "substitutionVal", "to_name" => "Name Surname 2"}
recipient = {email: 'test2@example.com', substitutions: substitutions, metadata: {"key1" => "val1"}}
mail.recipients << recipient

mail.metadata = {"key1" => "val1"}
mail.headers = {"X-ReplyTo" => "reply@example.com"}
mail.attachments << {"type" => "text/plain", "name" => "myfile.txt", "content" => "ZXhhbXBsZSBmaWxl"}
mail.inline_attachments << {"type" => "image/png", "name" => "IMAGECID", "content" => "iVBORw0KGgo"}
mail.options = {"unsubscribe_url" => "someurl"}

unione.send_email(mail.to_json)
