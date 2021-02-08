module UniOne
  class Client

    module Template

      def set_template(template)
        post 'template/set.json', template
        validate_response({
          'type' => 'object', 'required' => ['status', 'template'], 'properties' => {
           'status' => {'type' => 'string'},
           'template' => template_schema}
        })
      end

      def get_template(id)
        params = { id: id }
        post 'template/get.json', params
        validate_response({
          'type' => 'object', 'required' => ['status', 'template'], 'properties' => {
           'status' => {'type' => 'string'},
           'template' => template_schema}
        })
      end

      def list_templates(limit, offset)
        params = { limit: limit, offset: offset }
        post 'template/list.json', params
        list_template_schema = remove_fields_from_schema(template_schema, ['from_name', 'headers'])
        validate_response({
          'type' => 'object', 'required' => ['status', 'templates'], 'properties' => {
            'status' => {'type' => 'string'},
            'templates' => {'items' => list_template_schema}}
        })
      end

      def delete_template(id)
        params = { id: id }
        post 'template/delete.json', params
        validate_response({
          'type' => 'object', 'required' => ['status'], 'properties' => {
            'status' => {'type' => 'string'}}
        })
      end

      private

      def template_schema
        {'type' => 'object', 'required' => ['id', 'name', 'editor_type', 'subject', 'from_name', 'body', 'headers', 'attachments',
                                            'inline_attachments', 'options', 'created', 'user_id'], 'properties' => {
           'id' => {'type' => 'string'},
           'name' => {'type' => 'string'},
           'editor_type' => {'type' => 'string'},
           'subject' => {'type' => 'string'},
           'from_name' => {'type' => 'string'},
           'body' => template_body_schema,
           'headers' => {'type' => 'object'},
           'attachments' => {'items' => {'type' => 'object'}},
           'inline_attachments' => {'items' => {'type' => 'object'}},
           'options' => template_options_schema,
           'created' => {'type' => 'string'},
           'user_id' => {'type' => 'integer'},
         }}
      end

      def template_body_schema
        {'type' => 'object', 'required' => ['html', 'plaintext', 'amp'], 'properties' => {
           'html' => {'type' => 'string, null'},
           'plaintext' => {'type' => 'string, null'},
           'amp' => {'type' => 'string, null'}
         }}
      end

      def template_options_schema
        {'type' => 'object', 'required' => ['unsubscribe_url'], 'properties' => {
           'unsubscribe_url' => {'type' => 'string'}
         }}
      end

    end
  end
end
