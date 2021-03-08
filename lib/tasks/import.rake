require 'csv'

namespace :import_csv do
  desc "Imports a CSV file into an mongo table"

  task :create_airports => :environment do
    puts "cleaning collection"
    Airport.destroy_all

    puts "start importing airports"
    # TODO: future steps insert in batches
    CSV.foreach("#{Rails.root}/public/seed_data/airport-data.csv", :headers => true) do |row|
      data = row.to_hash
      Airport.create!(
        original_id:  data['ID'],
        name:         data['Airport Name'],
        city:         data['City'],
        country:      data['Country'],
        iata_faa:     data['IATA/FAA'],
        icao:         data['ICAO'],
        altitude:     data['Altitude'],
        timezone:     data['Timezone'],
        location:     {
          latitude:   data['Latitude'],
          longitude:  data['Longitude'],
        }
      )
    end
    puts "done importing airports... total imported: #{Airport.count}"
  end
end
