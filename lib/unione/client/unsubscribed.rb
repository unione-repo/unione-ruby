module UniOne
  class Client
    module Unsubscribed
      extend UniOne::Validation::ClassMethods
      include UniOne::Validation::InstanceMethods

      def unsubscribe(params = {})
        post('unsubscribed/set.json', params)
      end

      def check_unsubscribed(params = {})
        post('unsubscribed/check.json', params)
      end

      def list_unsubscribed(params = {})
        params[:date_from] = handle_date_param(params[:date_from]) if params[:date_from]

        post('unsubscribed/list.json', params)
      end

      add_response_validations(
        :unsubscribed,
        %w(
          unsubscribe
          check_unsubscribed
          list_unsubscribed
        )
      )
    end
  end
end
