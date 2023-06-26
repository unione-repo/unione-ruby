require 'unione-ruby'
require 'json'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  lang: 'en',
  api_key: ENV['UNIONE_API_KEY']
)

response = unione.subscribe_email(
  from_email: 'from@qadns.net',
  from_name: 'Example Sender',
  to_email: 'blackhole@example.com'
)
