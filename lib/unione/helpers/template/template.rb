module UniOne
  class Webhook
    attr_accessor :url, :event_format, :delivery_info, :single_event, :max_parallel, :events

    def to_json(*)
      {
        url: self.url,
        event_format: self.event_format,
        delivery_info: self.delivery_info,
        single_event: self.single_event,
        max_parallel: self.max_parallel,
        events: self.events
      }.delete_if { |_, value| value.to_s.strip == '' || value == [] || value == {}}
    end
  end
end
