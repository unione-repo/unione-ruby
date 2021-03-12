module UniOne
  class Client
    module System
      def info
        post 'system/info.json', {}
        validate_response({
          'type' => 'object', 'required' => ['status', 'user_id', 'email'], 'properties' => {
            'status' => {'type' => 'string'},
            'user_id' => {'type' => 'integer'},
            'email' => {'type' => 'string'},
            'accounting' =>
            {'type' => 'object', 'required' => ['period_start', 'period_end', 'emails_included', 'emails_sent'], 'properties' => [
             'period_start' => {'type' => 'string'},
             'period_end' => {'type' => 'string'},
             'emails_included' => {'type' => 'integer'},
             'emails_sent' => {'type' => 'integer'}
             ]},
            'project_id' => {'type' => 'string'},
            'project_name' => {'type' => 'string'}}
        })
      end
    end
  end
end
