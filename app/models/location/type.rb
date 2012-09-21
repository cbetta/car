class Location
  class Type
    
    def self.[] id
      TYPES[id]
    end
    
    protected
    
    TYPES = {
      1 => "ping",
      25 => "heartbeat"
    }
  end
end