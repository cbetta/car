class MapController < ApplicationController
  before_filter :require_login
  
  def index
    @location = Location.load_or_fetch
  end
end
