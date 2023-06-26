require 'unione-ruby'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  lang: 'en',
  api_key: ENV['UNIONE_API_KEY']
)

# Unsubscribe email
response = unione.unsubscribe(
  address: 'email@example.com'
)

# Check email is unsubscribed
response = unione.check_unsubscribed(
  address: 'email@example.com'
)

# List unsubscribed emails
response = unione.list_unsubscribed(
  date_from: Date.today # Or String: '2019-01-01'
)
