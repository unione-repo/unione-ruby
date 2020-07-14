require 'json'
require 'faraday'
require 'faraday_middleware'
require 'hashie'

module UniOne
  module Connection

    def get(url, params)
      params.merge!(default_params)
      # Assume http library receive get params as hash
      request :get, url, params
    end

    def post(url, params)
      params.merge!(default_params)
      # Assume http library receive post payload body as string
      request :post, url, JSON.dump(params)
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
      @conn ||= Faraday.new(
        url: api_endpoint,
        headers: {'Content-Type' => 'application/json'},
        request: { timeout: 30 }
      ) do |conn|
        conn.response :mashify, content_type: /\bjson$/
        conn.response :json, content_type: /\bjson$/
        conn.response :raise_error
        conn.adapter :net_http_persistent
      end
    end

    def default_params
      { api_key: @api_key }
    end

    def add_version(path)
      "#{path}?platform=unione_ruby_#{UniOne::VERSION}"
    end
  end
end
