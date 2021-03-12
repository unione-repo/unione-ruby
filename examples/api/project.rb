require 'unione-ruby'

unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])

# create project
response = unione.create_project({
  name: 'Project Name',
  send_enabled: true,
  # custom_unsubscribe_url_enabled: true, # Should have rights to use
})

puts response.status
puts response.body.to_h
puts response.headers

project_id = response.body.project_id

# update project
response = unione.update_project(
  {
    project_id: project_id
  },
  {
    name: 'New Project Name',
    send_enabled: true,
    # custom_unsubscribe_url_enabled: true, # Should have rights to use
  }
)

# list all projects
response = unione.list_projects

# list project by id
response = unione.list_projects({ project_id: project_id })

# delete project
response = unione.delete_project({ project_id: project_id })
