require 'unione-ruby'

unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])

# Generate/get DNS records for domain verification and DKIM signing
response = unione.get_dns_records("example.com")

puts response.status
puts response.body.to_h
puts response.headers

# Validate domain verification record before use
response = unione.validate_verification_record("example.com")

# Validate DKIM signature before sending
response = unione.validate_dkim("example.com")

# Get a list of your domains and their verification/DKIM statuses
response = unione.list_domains
