require_relative 'connection'
require_relative 'validation'
require_relative 'client/domain'
require_relative 'client/email'
require_relative 'client/template'
require_relative 'client/webhook'
require_relative 'client/unsubscribed'
require_relative 'client/project'

module UniOne

  class Client

    include UniOne::Connection
    include UniOne::Validation
    include UniOne::Client::Domain
    include UniOne::Client::Email
    include UniOne::Client::Template
    include UniOne::Client::Webhook
    include UniOne::Client::Unsubscribed
    include UniOne::Client::Project

    API_ENDPOINT =
      'https://%{data_center}.unione.io/%{lang}/transactional/api/v1/'

    # * *Args* :
    #   - +data_center+ -> data center: ['eu1', 'us1']
    #   - +lang+ -> Two-letter ISO 639-1 language abbreviation, e.g. 'en'
    #   - +api_key+ -> your UniOne API key
    #
    def initialize(data_center:, lang:, api_key:)
      @data_center = data_center
      @lang = lang
      @api_key = api_key
    end

    private

    def api_endpoint
      @api_endpoint ||=
        API_ENDPOINT % { data_center: @data_center, lang: @lang }
    end
  end
end
