require 'unione-ruby'

unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])

# get user or project information
response = unione.info

puts response.status
puts response.body.to_h
puts response.headers
