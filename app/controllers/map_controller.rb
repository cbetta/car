class MapController < ApplicationController
  def index
    @location = Location.load_or_fetch
  end
end
