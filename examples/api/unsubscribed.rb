require 'unione-ruby'

unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])

# unsubscribe email
response = unione.unsubscribe('email@example.com')

puts response.status
puts response.body.to_h
puts response.headers

# check email is unsubscribed
response = unione.check_unsubscribed('email@example.com')

# list unsubscribed emails
response = unione.list_unsubscribed('2019-01-01')
