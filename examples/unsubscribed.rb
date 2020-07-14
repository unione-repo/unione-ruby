require_relative '../../../lib/unione-ruby'
require 'json'

# Unsubscribe subscriber
unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])
response = unione.unsubscribe("email@example.com")
puts response.status
puts response.body.to_h
puts response.headers

# Check unsubscribed
response = unione.check_unsubscribed("email@example.com")

# List unsubscribed
response = unione.list_unsubscribed("2019-01-01")
