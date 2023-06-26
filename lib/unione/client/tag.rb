module UniOne
  class Client
    module Tag
      extend UniOne::Validation::ClassMethods
      include UniOne::Validation::InstanceMethods

      def list_tags(params = {})
        post('tag/list.json', params)
      end

      def delete_tag(params = {})
        post('tag/delete.json', params)
      end

      add_response_validations(
        :tag,
        %w(
          list_tags
          delete_tag
        )
      )
    end
  end
end
