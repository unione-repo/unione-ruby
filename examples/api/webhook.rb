require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  api_key: ENV['UNIONE_API_KEY']
)

# Set webhook
params = {}

params[:url] = 'http://example.com'
params[:status] = :active

params[:event_format] = :json_post
params[:delivery_info] = 1
params[:single_event] = 0
params[:max_parallel] = 10

params[:events] = {
  email_status: %w(sent delivered opened hard_bounced soft_bounced spam clicked unsubscribed),
  spam_block: ["*"]
}

response = unione.set_webhook(params)

# Get webhook
response = unione.get_webhook(
  url: 'http://example.com'
)

# List all webhooks
response = unione.list_webhooks(
  limit: 50,
  offset: 0
)

# Delete webhook
response = unione.delete_webhook(
  url: 'http://example.com'
)
