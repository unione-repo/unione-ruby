module UniOne
  class Mail
    attr_accessor :template, :body, :track, :from, :subject, :metadata, :headers, :options,
                  :global_substitutions, :recipients, :attachments, :inline_attachments,
                  :reply_to

    def initialize
      @template = {}
      @from = {}
      @track = {}
      @global_substitutions = {}
      @recipients = []
      @attachments = []
      @inline_attachments = []
    end

    def to_json(*)
      {
        message: {
          global_substitutions: self.global_substitutions,
          body: self.body,
          subject: self.subject,
          reply_to: self.reply_to,
          recipients: self.recipients,
          metadata: self.metadata,
          headers: self.headers,
          attachments: self.attachments,
          inline_attachments: self.inline_attachments,
          options: self.options
        }.merge(self.template)
         .merge(self.from)
         .merge(self.track)
         .delete_if { |_, value| value.to_s.strip == '' || value == [] || value == {}}
      }
    end
  end
end
