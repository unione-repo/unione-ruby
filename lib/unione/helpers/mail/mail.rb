module UniOne
  class Mail
    attr_accessor :template, :body, :track, :from, :subject, :global_metadata, :headers, :options,
                  :global_substitutions, :recipients, :attachments, :inline_attachments,
                  :reply_to, :skip_unsubscribe, :force_send

    def initialize
      @template = {}
      @from = {}
      @track = {}
      @global_substitutions = {}
      @recipients = []
      @attachments = []
      @inline_attachments = []
    end

    # backward compatibility
    alias_method :"metadata=", :"global_metadata="

    def to_json(*)
      {
        message: {
          global_substitutions: self.global_substitutions,
          body: self.body,
          subject: self.subject,
          reply_to: self.reply_to,
          recipients: self.recipients,
          global_metadata: self.global_metadata,
          headers: self.headers,
          attachments: self.attachments,
          inline_attachments: self.inline_attachments,
          options: self.options,
          skip_unsubscribe: self.skip_unsubscribe,
          force_send: self.force_send
        }.merge(self.template)
         .merge(self.from)
         .merge(self.track)
         .delete_if { |_, value| value.to_s.strip == '' || value == [] || value == {}}
      }
    end
  end
end
