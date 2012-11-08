namespace :location do
  desc "Update current location"
  task :load_current => :environment do
    Location::Loader.new.async_load_current
  end

  desc "Update past locations"
  task :load_past => :environment do
    Location::Loader.new.async_load_past 2.days.ago
  end
end
