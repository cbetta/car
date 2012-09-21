class MapController < ApplicationController
  before_filter :require_login, :require_access
  
  def index
    @location = Location.current
  end
end
