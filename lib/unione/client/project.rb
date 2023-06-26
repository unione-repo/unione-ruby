module UniOne
  class Client
    module Project
      extend UniOne::Validation::ClassMethods
      include UniOne::Validation::InstanceMethods

      def create_project(params = {})
        post('project/create.json', params)
      end

      def update_project(params = {})
        post('project/update.json', params)
      end

      def list_projects(params = {})
        post('project/list.json', params)
      end

      def delete_project(params = {})
        post('project/delete.json', params)
      end

      add_response_validations(
        :project,
        %w(
          create_project
          update_project
          list_projects
          delete_project
        )
      )
    end
  end
end
