module UniOne
  class Webhook
    attr_accessor :url, :status, :settings, :events

    def initialize
      @settings = {}
    end

    def to_json(*)
      {
        url: self.url,
        status: self.status,
        events: self.events
      }.merge(self.settings)
        .delete_if { |_, value| value.to_s.strip == '' || value == [] || value == {}}
    end
  end
end
