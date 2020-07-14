module UniOne
  class Client

    module Project

      def create_project(project)
        params = { project: project }
        post 'project/create.json', params
        validate_response({
          'type' => 'object', 'required' => ['status', 'project_api_key'], 'properties' => {
            'status' => {'type' => 'string'},
            'project_api_key' => {'type' => 'string'}}
        })
      end

      def update_project(project_api_key, project)
        params = { project_api_key: project_api_key, project: project }
        post 'project/update.json', params
        validate_response({
          'type' => 'object', 'required' => ['status', 'project_api_key'], 'properties' => {
            'status' => {'type' => 'string'},
            'project_api_key' => {'type' => 'string'}}
        })
      end

      def delete_project(project_api_key)
        params = { project_api_key: project_api_key }
        post 'project/delete.json', params
        validate_response({
          'type' => 'object', 'required' => ['status'], 'properties' => {
            'status' => {'type' => 'string'}}
        })
      end

      def list_projects(project_api_key = nil)
        params = { project_api_key: project_api_key }
        post 'project/list.json', params
        validate_response({
          'type' => 'object', 'required' => ['status'], 'properties' => {
            'status' => {'type' => 'string'},
            'projects' => {'items' => project_schema}}
        })
      end

      private

      def project_schema
        {'type' => 'object', 'required' => ['api_key', 'name', 'reg_time', 'send_enabled', 'custom_unsubscribe_url_enabled'], 'properties' => {
           'api_key' => {'type' => 'string'},
           'name' => {'type' => 'string'},
           'reg_time' => {'type' => 'string'},
           'send_enabled' => {'type' => 'boolean'},
           'custom_unsubscribe_url_enabled' => {'type' => 'boolean'}
         }}
      end
    end
  end
end
