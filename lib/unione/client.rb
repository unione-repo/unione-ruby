require_relative 'connection'
require_relative 'validation'
require_relative 'helpers'
require_relative 'client/domain'
require_relative 'client/email'
require_relative 'client/event_dump'
require_relative 'client/project'
require_relative 'client/suppression'
require_relative 'client/system'
require_relative 'client/tag'
require_relative 'client/template'
require_relative 'client/unsubscribed'
require_relative 'client/webhook'

module UniOne
  class Client
    include UniOne::Connection
    extend  UniOne::Validation::ClassMethods
    include UniOne::Validation::InstanceMethods
    include UniOne::Client::Helpers
    include UniOne::Client::Domain
    include UniOne::Client::Email
    include UniOne::Client::EventDump
    include UniOne::Client::Project
    include UniOne::Client::Suppression
    include UniOne::Client::System
    include UniOne::Client::Tag
    include UniOne::Client::Template
    include UniOne::Client::Unsubscribed
    include UniOne::Client::Webhook

    class BaseException < StandardError; end
    class InvalidCallbackAuth < BaseException; end

    API_ENDPOINT =
      'https://%{hostname}/%{lang}/transactional/api/v1/'

    # * *Args* :
    #   - +hostname+          -> string, API hostname, for example 'eu1.unione.io'
    #   - +lang+              -> string, two-letter ISO 639-1 language abbreviation, e.g. 'en'
    #   - +api_key+           -> string, your UniOne API key
    #   - +timeout+           -> integer, timeout in seconds, 5 by default
    #   - +api_key_in_params+ -> boolean, pass API key in parameters, otherwise pass in headers (default)
    #   - +enable_logging+    -> boolean, enable logging
    def initialize(params = {})
      @hostname          = params[:hostname]
      @lang              = params[:lang]
      @api_key           = params[:api_key]
      @timeout           = params[:timeout] || 5
      @api_key_in_params = params[:api_key_in_params]
      @enable_logging    = params[:enable_logging] || ENV['ENABLE_LOGGING']
    end

    private

    def api_endpoint
      @api_endpoint ||=
        API_ENDPOINT % { hostname: @hostname, lang: @lang }
    end

    def handle_time_param(param)
      param.respond_to?(:strftime) ? param.strftime('%Y-%m-%d %H:%M:%S') : param
    end

    def handle_date_param(param)
      param.respond_to?(:strftime) ? param.strftime('%Y-%m-%d') : param
    end
  end
end
