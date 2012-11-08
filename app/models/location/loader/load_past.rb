class Location
  class Loader
    class LoadPast
      @queue = :fetcher

      def self.perform from
        from = Time.parse(from)
        Location::Loader.new.load_past from
      end
    end
  end
end