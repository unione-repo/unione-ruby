module UniOne
  class Client
    module Suppression
      extend UniOne::Validation::ClassMethods
      include UniOne::Validation::InstanceMethods

      def set_suppression(params = {})
        params[:created] = handle_time_param(params[:created]) if params[:created]

        post('suppression/set.json', params)
      end

      def get_suppression(params = {})
        post('suppression/get.json', params)
      end

      def list_suppressions(params = {})
        params[:start_time] = handle_time_param(params[:start_time]) if params[:start_time]

        post('suppression/list.json', params)
      end

      def delete_suppression(params = {})
        post('suppression/delete.json', params)
      end

      add_response_validations(
        :suppression,
        %w(
          set_suppression
          get_suppression
          list_suppressions
          delete_suppression
        )
      )
    end
  end
end
