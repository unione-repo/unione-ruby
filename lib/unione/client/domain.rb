module UniOne
  class Client
    module Domain
      extend UniOne::Validation::ClassMethods
      include UniOne::Validation::InstanceMethods

      def get_dns_records(params = {})
        post('domain/get-dns-records.json', params)
      end

      def validate_verification_record(params = {})
        post('domain/validate-verification-record.json', params)
      end

      def validate_dkim(params = {})
        post('domain/validate-dkim.json', params)
      end

      def list_domains(params = {})
        post('domain/list.json', params)
      end

      add_response_validations(
        :domain,
        %w(
          get_dns_records
          validate_verification_record
          validate_dkim
          list_domains
        )
      )
    end
  end
end
