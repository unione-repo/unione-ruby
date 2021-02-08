require 'json'
require 'faraday'
require 'faraday_middleware'
require 'hashie'

module UniOne
  module Connection

    def get(url, params)
      prepare_params!(params)

      # Assume HTTP library receives params as Hash
      request(:get, url, params)
    end

    def post(url, params)
      prepare_params!(params)

      # Assume HTTP library receives payload body as String
      request(:post, url, JSON.dump(params))
    end

    private

    def request(method, path, data)
      path = add_version(path)
      begin
        @last_response = conn.send(method, path, data)
      rescue Faraday::Error => e
        puts e.response[:body]
        raise
      end
    end

    def conn
      headers = {'Content-Type' => 'application/json'}
      prepare_headers!(headers)

      @conn ||= Faraday.new(
        url: api_endpoint,
        headers: headers,
        request: { timeout: 30 }
      ) do |conn|
        conn.response :mashify, content_type: /\bjson$/
        conn.response :json, content_type: /\bjson$/
        conn.response :raise_error
        conn.adapter :net_http_persistent
      end
    end

    def prepare_params!(params)
      params.merge!({api_key: @api_key}) if @api_key_in_params
    end

    def prepare_headers!(headers)
      headers.merge!('X-API-KEY' => @api_key) unless @api_key_in_params
    end

    def add_version(path)
      "#{path}?platform=unione_ruby_#{UniOne::VERSION}"
    end
  end
end
