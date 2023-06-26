module UniOne
  class Client
    module EventDump
      extend UniOne::Validation::ClassMethods
      include UniOne::Validation::InstanceMethods

      def create_event_dump(params = {})
        params[:start_time] = handle_time_param(params[:start_time]) if params[:start_time]
        params[:end_time] = handle_time_param(params[:end_time]) if params[:end_time]

        post('event-dump/create.json', params)
      end

      def get_event_dump(params = {})
        post('event-dump/get.json', params)
      end

      def list_event_dumps(params = {})
        post('event-dump/list.json', params)
      end

      def delete_event_dump(params = {})
        post('event-dump/delete.json', params)
      end

      add_response_validations(
        :event_dump,
        %w(
          create_event_dump
          get_event_dump
          list_event_dumps
          delete_event_dump
        )
      )
    end
  end
end
