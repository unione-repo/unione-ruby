require 'unione-ruby'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  api_key: ENV['UNIONE_API_KEY']
)

# Create event dump
filter = {
  job_id: '1ZymBc-00041N-9X',
  status: 'sent',
  delivery_status: 'err_user_unknown',
  email: 'david@example.org',
  email_from: 'sender@example.com',
  domain: 'example.org',
  campaign_id: 'c77f4f4e-3561-49f7-9f07-c35be01b4f43'
}

response = unione.create_event_dump(
  start_time: Time.now, # Or String: '2022-07-20 00:00:00'
  end_time: Time.now, # Or String: '2022-07-21 00:00:00'
  limit: 50,
  all_projects: false,
  filter: filter,
  delimiter: ';',
  format: 'csv'
)

# Get id of created event dump
dump_id = response.body.dump_id

# Get event dump
response = unione.get_event_dump(
  dump_id: dump_id
)

# List event dumps
response = unione.list_event_dumps

# Delete event dump
response = unione.delete_event_dump(
  dump_id: dump_id
)
