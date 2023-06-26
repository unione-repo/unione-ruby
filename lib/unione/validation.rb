require 'json-schema'
require 'yaml'

module UniOne
  module Validation
    module ClassMethods
      def add_response_validations(klass, methods)
        methods.each do |method|
          orig = "#{method}_without_hook"
          alias_method orig, method

          define_method method do |*args|
            send(orig, *args)
            schema = get_response_schema(klass, method)
            validate_response(schema)
          end
        end
      end
    end

    module InstanceMethods
      private

      def validate_response(schema)
        JSON::Validator.validate!(schema, @last_response.body)
        @last_response
      end

      def get_response_schema(klass, method)
        @response_schemas ||= {}
        @response_schemas[klass] ||= begin
          directory = File.join(File.dirname(__FILE__), '..', '..', 'config', 'response_schema')
          filename = "#{klass}.yml"
          YAML.load_file(File.join(directory, filename))
        end

        @response_schemas[klass][method]
      end

      def undescore_class_name(class_name)
        class_name.gsub(/([^\^])([A-Z])/,'\1_\2').downcase
      end
    end
  end
end
