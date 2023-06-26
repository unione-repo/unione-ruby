module UniOne
  class Client
    module Template
      extend UniOne::Validation::ClassMethods
      include UniOne::Validation::InstanceMethods

      def set_template(params = {})
        post('template/set.json', params)
      end

      def get_template(params = {})
        post('template/get.json', params)
      end

      def list_templates(params = {})
        post('template/list.json', params)
      end

      def delete_template(params = {})
        post('template/delete.json', params)
      end

      add_response_validations(
        :template,
        %w(
          set_template
          get_template
          list_templates
          delete_template
        )
      )
    end
  end
end
