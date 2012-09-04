class Location < ActiveRecord::Base
  attr_accessible :area, :latitude, :longitude, :seen
  
  LOCATION_URL = "https://drivetoimprove.co.uk/api/m/AllVehiclesStatus".freeze

  def self.load_or_fetch
    latest = Location.order("created_at DESC").last
    return Location.fetch if latest.nil? || latest.created_at < 3.minutes.ago
    latest
  end
    
  def self.fetch
    status = Faraday.new do |faraday|
      faraday.response :json, :content_type => /\bjson$/
      faraday.basic_auth ENV["D2I_EMAIL"], ENV["D2I_PASSWORD"]
      faraday.adapter Faraday.default_adapter
    end.get(LOCATION_URL).body["GetAllVehiclesStatusResult"].first
    
    Location.create! area: Location.area_from(status), latitude: status["gpsLatitude"], longitude: status["gpsLongitude"], seen: Time.at(status["gpsTimeLong"].to_i/10000000)
  end
  
  def self.area_from status
    [
      status["geoPOI"],
      status["geoStreet"],
      status["geoTown"],
      status["geoCountry"],
    ].reject(&:blank?).compact.join(", ")
  end
end