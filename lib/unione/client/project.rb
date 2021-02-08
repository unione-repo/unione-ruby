module UniOne
  class Client
    module Project
      def create_project(project)
        params = { project: project }
        post 'project/create.json', params
        validate_response({
          'type' => 'object', 'required' => ['status', 'project_id', 'project_api_key'], 'properties' => {
            'status' => {'type' => 'string'},
            'project_id' => {'type' => 'string'},
            'project_api_key' => {'type' => 'string'}}
        })
      end

      def update_project(project_identity, project)
        params = get_identity(project_identity).merge(project: project)
        post 'project/update.json', params
        validate_response({
          'type' => 'object', 'required' => ['status'], 'properties' => {
            'status' => {'type' => 'string'},
            'project_api_key' => {'type' => 'string'}}
        })
      end

      def list_projects(project_identity = nil)
        params = get_identity(project_identity)
        post 'project/list.json', params
        validate_response({
          'type'       => 'object',
          'required'   => %w{ status },
          'properties' => {
            'status'     => { 'type' => 'string' },
            'projects'   => { 'items' => project_schema }
          }
        })
      end

      def delete_project(project_identity)
        params = get_identity(project_identity)
        post 'project/delete.json', params
        validate_response({
          'type'       => 'object',
          'required'   => %w{ status },
          'properties' => {
            'status' => { 'type' => 'string' }
          }
        })
      end

      private

      def get_identity(project_identity)
        if project_identity.is_a?(Hash)
          project_identity
        elsif project_identity
          { project_api_key: project_identity }
        else
          {}
        end
      end

      def project_schema
        {'type'       => 'object',
         'required'   => %w{ id api_key name reg_time send_enabled custom_unsubscribe_url_enabled },
         'properties' => {
           'id'                             => {'type' => 'string'},
           'api_key'                        => {'type' => 'string'},
           'name'                           => {'type' => 'string'},
           'reg_time'                       => {'type' => 'string'},
           'send_enabled'                   => {'type' => 'boolean'},
           'custom_unsubscribe_url_enabled' => {'type' => 'boolean'}
         }}
      end
    end
  end
end
