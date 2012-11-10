namespace :location do
  desc "Update current location"
  task :load_current => :environment do
    puts "FOO!"
    Location::Loader.new.load_current
  end

  desc "Update past locations"
  task :load_past => :environment do
    Location::Loader.new.load_past 2.days.ago
  end
end
