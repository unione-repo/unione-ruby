require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])

# set webhook
webhook = UniOne::Webhook.new

webhook.url      = 'http://example.com'
webhook.status   = :active

webhook.settings = {
  event_format: :json_post,
  delivery_info: 1,
  single_event: 0,
  max_parallel: 10
}

webhook.events = {
  email_status: %w(sent delivered opened hard_bounced soft_bounced spam clicked unsubscribed),
  spam_block: ["*"]
}

puts webhook.to_json

response = unione.set_webhook(webhook.to_json)

puts response.status
puts response.body.to_h
puts response.headers

# get webhook
response = unione.get_webhook('http://example.com')

# list all webhooks
response = unione.list_webhooks(50, 0)

# delete webhook
response = unione.delete_webhook('http://example.com')
