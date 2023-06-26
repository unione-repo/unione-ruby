module UniOne
  class Client
    module Email
      extend UniOne::Validation::ClassMethods
      include UniOne::Validation::InstanceMethods

      def send_email(params = {})
        params[:message][:options][:send_at] = handle_time_param(params.dig(:message, :options, :send_at)) if params.dig(:message, :options, :send_at)
        post('email/send.json', params)
      end

      def subscribe_email(params = {})
        post('email/subscribe.json', params)
      end

      add_response_validations(
        :email,
        %w(
          send_email
          subscribe_email
        )
      )
    end
  end
end
