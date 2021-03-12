require_relative 'connection'
require_relative 'validation'
require_relative 'client/domain'
require_relative 'client/email'
require_relative 'client/project'
require_relative 'client/system'
require_relative 'client/template'
require_relative 'client/unsubscribed'
require_relative 'client/webhook'

module UniOne

  class Client

    include UniOne::Connection
    include UniOne::Validation
    include UniOne::Client::Domain
    include UniOne::Client::Email
    include UniOne::Client::Project
    include UniOne::Client::System
    include UniOne::Client::Template
    include UniOne::Client::Unsubscribed
    include UniOne::Client::Webhook

    API_ENDPOINT =
      'https://%{data_center}.unione.io/%{lang}/transactional/api/v1/'

    # * *Args* :
    #   - +data_center+ -> data center: ['eu1', 'us1']
    #   - +lang+ -> Two-letter ISO 639-1 language abbreviation, e.g. 'en'
    #   - +api_key+ -> your UniOne API key
    #   - +api_key_in_params+ -> boolean, pass API key inside form, otherwise pass in headers (default in headers)
    def initialize(params = {})
      @data_center       = params[:data_center]
      @lang              = params[:lang]
      @api_key           = params[:api_key]
      @api_key_in_params = !!params[:api_key_in_params]
    end

    private

    def api_endpoint
      @api_endpoint ||=
        API_ENDPOINT % { data_center: @data_center, lang: @lang }
    end
  end
end
