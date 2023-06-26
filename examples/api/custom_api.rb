require 'unione-ruby'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  lang: 'en',
  api_key: ENV['UNIONE_API_KEY']
)

# Custom Api call
response =
  unione.post(
    'domain/get-dns-records.json',
    domain: 'example.com'
  )
