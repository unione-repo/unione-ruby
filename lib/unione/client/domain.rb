module UniOne
  class Client
    module Domain
      def get_dns_records(domain)
        params = { domain: domain }
        post 'domain/get-dns-records.json', params
        validate_response({
          'type' => 'object', 'required' => ['status', 'domain', 'verification-record', 'dkim'], 'properties' => {
            'status' => {'type' => 'string'},
            'domain' => {'type' => 'string'},
            'verification-record' => {'type' => 'string'},
            'dkim' => {'type' => 'string'}}
        })
      end

      def validate_verification_record(domain)
        params = { domain: domain }
        post 'domain/validate-verification-record.json', params
        validate_response({
          'type' => 'object', 'required' => ['status', 'message'], 'properties' => {
            'status' => {'type' => 'string'},
            'message' => {'type' => 'string'}}
        })
      end

      def validate_dkim(domain)
        params = { domain: domain }
        post 'domain/validate-dkim.json', params
        validate_response({
          'type' => 'object', 'required' => ['status', 'message'], 'properties' => {
            'status' => {'type' => 'string'},
            'message' => {'type' => 'string'}}
        })
      end

      def list_domains
        post 'domain/list.json', {}
        validate_response({
          'type' => 'object', 'required' => ['status', 'domains'], 'properties' => {
            'status' => {'type' => 'string'},
            'domains' =>
            {'items' =>
             {'type' => 'object', 'required' => ['domain', 'verification-record', 'dkim'], 'properties' => [
              'domain' => {'type' => 'string'},
              'verification-record' =>
              {'type' => 'object', 'required' => ['value', 'status'], 'properties' => [
               'value' => {'type' => 'string'},
               'status' => {'type' => 'string'}]},
              'dkim' =>
              {'type' => 'object', 'required' => ['key', 'status'], 'properties' => [
               'key' => {'type' => 'string'},
               'status' => {'type' => 'string'}]}
              ]}}}
        })
      end
    end
  end
end
