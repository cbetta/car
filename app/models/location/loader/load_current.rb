class Location
  class Loader
    class LoadCurrent
      @queue = :fetcher

      def self.perform
        Location::Loader.new.load_current
      end
    end
  end
end