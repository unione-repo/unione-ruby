require 'unione-ruby'

unione = UniOne::Client.new(
  hostname: 'eu1.unione.io',
  api_key: ENV['UNIONE_API_KEY']
)

# Create project
response = unione.create_project(
  project: {
    name: 'Project Name',
    country: 'ES',
    send_enabled: true,
    custom_unsubscribe_url_enabled: true # Need permission
  }
)

# Get id of created project
project_id = response.body.project_id

# Update project
response = unione.update_project(
  project_id: project_id,
  project: {
    name: 'Project Name',
    country: 'ES',
    send_enabled: true,
    custom_unsubscribe_url_enabled: true # Need permission
  }
)

# List projects
response = unione.list_projects

# List project by id
response = unione.list_projects(
  project_id: project_id
)

# Delete project
response = unione.delete_project(
  project_id: project_id
)
