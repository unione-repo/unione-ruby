require 'unione-ruby'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  api_key: ENV['UNIONE_API_KEY']
)

# List tags
response = unione.list_tags

# Delete tag
response = unione.delete_tag(
  tag_id: tag_id
)
