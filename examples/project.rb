require_relative '../../../lib/unione-ruby'
require 'json'

# Create project
unione = UniOne::Client.new(data_center: 'eu1', lang: 'en', api_key: ENV['UNIONE_API_KEY'])
response = unione.create_project(
  {"name" => "Projectname 2", "send_enabled" => true, "custom_unsubscribe_url_enabled" => true})
puts response.status
puts response.body.to_h
puts response.headers

# Update project
response = unione.update_project("5qugsquc85i1e87xfb4spgxh8bnmi1pjfrtx1w1c",
  {"name" => "Projectname 2", "send_enabled" => true, "custom_unsubscribe_url_enabled" => true})

# Delete project
response = unione.delete_project("5qegsquc85i1e87xfb4spgxh8bnmi1pjfrtx1w1c")

# List projects
response = unione.list_projects
response = unione.list_projects("5qegsquc85i1e87xfb4spgxh8bnmi1pjfrtx1w1c")
