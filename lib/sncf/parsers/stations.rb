module Sncf
  module Parsers
    class Stations < Sncf::Parsers::Default
      def get_stations_list
        stations, administrative_regions = [], []

        @api_response.content['places'].each do |place|
          if place['embedded_type'] == 'stop_area'
            place['stop_area']['administrative_regions'].each do |administrative_region|
              administrative_regions << create_model('AdministrativeRegion', {
                id: administrative_region['id'],
                insee: administrative_region['insee'],
                level: administrative_region['level'],
                coord: administrative_region['coord'],
                name: administrative_region['name'],
                label: administrative_region['label'],
                zip_code: administrative_region['zip_code']
              })
            end

            stations << create_model('Station', {
              id: place['id'],
              coord: place['stop_area']['coord'],
              quality: place['quality'],
              name: place['stop_area']['name'],
              label: place['stop_area']['label'],
              timezone: place['stop_area']['timezone'],
              administrative_regions: administrative_regions
            })
          end
        end

        stations
      end
    end
  end
end
