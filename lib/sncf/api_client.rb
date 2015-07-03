require 'http'
require 'oj'

module Sncf
  class ApiClient
    BASE_URL      = 'https://api.sncf.com'
    VERSION_PATH  = 'v1'
    PLAN          = {
      name: 'Free',
      limits: {
        per_day: 3_000,
        per_month: 90_000
      }
    }

    attr_reader :api_key

    def initialize(api_key)
      if !api_key.is_a?(String) || api_key.strip == ''
        raise ArgumentError, "You must specify your SNCF api_key as a non-empty string."
      else
        @api_key = api_key
      end
    end

    def quotas
      @quotas ||= begin
        {
          per_day: PLAN[:limits][:per_day],
          per_month: PLAN[:limits][:per_month]
        }
      end
    end

    def fetch(path, additional_params = nil)
      query     = construct_formated_url path, additional_params
      response  = Http.basic_auth(user: @api_key, pass: nil).get query
      if response.code == 200
        Sncf::ApiResponse.new response, query
      else
        raise ArgumentError, "Unauthorized (#{response.code}) #{response.body}"
      end
    end

    def fetch_stations(place)
      raise ArgumentError, "The fetch_place argument should be a string, example: 'Paris Nord'." if place.to_s == ''

      stations_response = fetch('coverage/sncf/places', {
        q: place
      })

      Sncf::Parsers::Stations.new(stations_response).get_stations_list
    end

    def fetch_journeys_by_stations(from, to, time, options = {})
      raise ArgumentError, "The `from` argument should be a string, example: 'Paris Nord'." if from.to_s == ''
      raise ArgumentError, "The `to` argument should be a string, example: 'Paris Nord'." if to.to_s == ''
      raise ArgumentError, "The `time` argument should be Time or DateTime." unless time.is_a?(Time) || time.is_a?(DateTime)

      from_station  = fetch_stations(from).first
      to_station    = fetch_stations(to).first

      case
      when from_station.nil?
        raise ArgumentError, "The '#{from}' station doesn't exist."
      when to_station.nil?
        raise ArgumentError, "The '#{to}' station doesn't exist."
      else
        fetch_journeys_by_station_ids from_station.id, to_station.id, time, options
      end
    end

    def fetch_journeys_by_station_ids(from_station_id, to_station_id, time, options)
      fetch_options = {
        from: from_station_id,
        to: to_station_id,
        datetime: time.to_datetime.strftime('%Y%m%dT%H%M%S')
      }.merge(options)
      fetch('coverage/sncf/journeys', fetch_options)
    end

    protected

    def construct_formated_url(path, additional_params)
      if additional_params.nil? || additional_params.empty?
        "#{BASE_URL}/#{VERSION_PATH}/#{path}"
      else
        "#{BASE_URL}/#{VERSION_PATH}/#{path}?#{additional_params.map{|k,v| "#{k}=#{v}"}.join('&')}"
      end
    end
  end
end
