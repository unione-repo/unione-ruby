require 'unione-ruby'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  lang: 'en',
  api_key: ENV['UNIONE_API_KEY']
)

# Get user or project info
response = unione.info
