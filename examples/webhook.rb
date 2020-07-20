require 'unione-ruby'
require 'json'

# Set webhook
webhook = UniOne::Webhook.new
webhook.url = "http://example.com"
webhook.event_format = "json_post"
webhook.delivery_info = 1
webhook.single_event = 0
webhook.max_parallel = 10
webhook.events = {email_status: [
  "sent",
  "delivered",
  "opened",
  "hard_bounced",
  "soft_bounced",
  "spam",
  "clicked",
  "unsubscribed"
], spam_block: ["*"]}

puts webhook.to_json

unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])
response = unione.set_webhook(webhook.to_json)
puts response.status
puts response.body.to_h
puts response.headers

# Get webhook
unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])
response = unione.get_webhook("http://example.com")

# Delete webhook
response = unione.delete_webhook("http://example.com")
