class Location
  class Loader
    CURRENT_LOCATION_URL = "https://drivetoimprove.co.uk/api/m/AllVehiclesStatus".freeze
    TICKS_URL = "https://drivetoimprove.co.uk/api/m/TelemetryInfoByType/%s?from=%s&to=%s&type=1,25".freeze

    def async_load_current
      Resque.enqueue Location::Loader::LoadCurrent
    end

    def async_load_past from
      Resque.enqueue Location::Loader::LoadPast, from.to_s
    end

    def load_current
      status = connection.get(CURRENT_LOCATION_URL).body["GetAllVehiclesStatusResult"].first
      Location.from(status)
    end

    def load_past from = Time.now, to = 1.day.from_now
      url = TICKS_URL % [ENV["D2I_DEVICE_ID"], from.strftime("%Y-%m-%d"), to.strftime("%Y-%m-%d")]
      statuses = connection.get(url).body["GetTelemetryInfoByTypeResult"]
      statuses.map {|status| Location.from(status) }
    end

    def connection
      @connection ||= Faraday.new do |faraday|
        faraday.response :json, :content_type => /\bjson$/
        faraday.basic_auth ENV["D2I_EMAIL"], ENV["D2I_PASSWORD"]
        faraday.adapter Faraday.default_adapter
      end
    end

  end
end