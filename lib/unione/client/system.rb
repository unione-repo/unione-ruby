module UniOne
  class Client
    module System
      extend UniOne::Validation::ClassMethods
      include UniOne::Validation::InstanceMethods

      def info(params = {})
        post('system/info.json', params)
      end

      add_response_validations(
        :system,
        %w(
          info
        )
      )
    end
  end
end
