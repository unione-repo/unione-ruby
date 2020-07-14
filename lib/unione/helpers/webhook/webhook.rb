module UniOne
  class Template
    attr_accessor :name, :subject, :template_engine, :global_substitutions, :from,
                  :headers, :body, :attachments, :inline_attachments, :options

    def initialize
      @global_substitutions = {}
      @from = {}
      @attachments = []
      @inline_attachments = []
    end

    def to_json(*)
      {
        template: {
          id: '',
          name: self.name,
          subject: self.subject,
          template_engine: self.template_engine,
          global_substitutions: self.global_substitutions,
          headers: self.headers,
          body: self.body,
          attachments: self.attachments,
          inline_attachments: self.inline_attachments,
          options: self.options
        }.merge(self.from)
          .delete_if { |_, value| value.to_s.strip == '' || value == [] || value == {}}
      }
    end
  end
end
