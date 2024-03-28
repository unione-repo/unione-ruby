require 'unione-ruby'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  api_key: ENV['UNIONE_API_KEY']
)

# Generate/get DNS records for domain verification and DKIM signing
response = unione.get_dns_records(
  domain: 'example.com'
)

# Validate domain verification record before use
response = unione.validate_verification_record(
  domain: 'example.com'
)

# Validate DKIM signature before sending
response = unione.validate_dkim(
  domain: 'example.com'
)

# Get a list of your domains and their verification/DKIM statuses
response = unione.list_domains
