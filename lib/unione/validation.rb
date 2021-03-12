require 'json-schema'

module UniOne
  module Validation

    private

    def validate_response(schema)
      JSON::Validator.validate!(schema, @last_response.body)
      @last_response
    end

    def remove_fields_from_schema(schema, fields)
      schema.dup.tap do |s|
        s['required'] = s['required'].reject { |f| fields.include?(f) }
        s['properties'] = s['properties'].reject { |f| fields.include?(f) }
      end
    end
  end
end
