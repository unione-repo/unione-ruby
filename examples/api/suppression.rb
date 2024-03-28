require 'unione-ruby'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  api_key: ENV['UNIONE_API_KEY']
)

# Create suppression
response = unione.set_suppression(
  email: 'user@example.com',
  cause: 'unsubscribed',
  created: Time.now, # Or String: '2021-12-19 10:15:49'
)

# Get suppression
response = unione.get_suppression(
  email: 'user@example.com',
  all_projects: false
)

# List suppressions
response = unione.list_suppressions(
  cause: 'unsubscribed',
  source: 'user',
  start_time: Time.now, # Or String: '2021-12-19 10:15:49'
  cursor: 'Ajfb6Hvdkn3hdhhvG57xbdufhG5',
  limit: 50
)

# Delete suppression
response = unione.delete_suppression(
  email: 'user@example.com'
)
