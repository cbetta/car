class Location < ActiveRecord::Base
  attr_accessible :area, :latitude, :longitude, :seen
  
  def self.current
    latest = Location.order("created_at DESC").first
    return Location::Loader.new.load_current if latest.nil? || latest.created_at < 1.minutes.ago
    latest
  end
  
  def self.from status
    seen =  Time.at(status["gpsTimeLong"].to_i/10_000_000)
    area = [ status["geoPOI"],
      status["geoStreet"],
      status["geoTown"],
      status["geoCountry"],
    ].reject(&:blank?).compact.join(", ")
    
    latitude = status["gpsLatitude"] || status["gpsPosition"]["Latitude"]["Radians"]
    longitude = status["gpsLongitude"] || status["gpsPosition"]["Longitude"]["Radians"]
    
    Location.where(area: area, latitude: latitude.to_s, longitude: longitude.to_s, seen: seen).first_or_create!
  end
end