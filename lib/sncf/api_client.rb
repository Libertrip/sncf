require 'http'
require 'oj'

module Sncf
  class ApiClient
    HOST_URL          = 'https://api.sncf.com'
    BASE_PATH         = 'v1'
    PLAN = {
      name: 'Free',
      limits: {
        per_day: 3_000,
        per_month: 90_000
      }
    }

    # => 3aa53f6d-13f1-486b-8a68-a781842cbe73

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
        { per_day: PLAN[:limits][:per_day], per_month: PLAN[:limits][:per_month] }
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

    protected

    def construct_formated_url(path, additional_params)
      if additional_params.nil?
        "#{HOST_URL}/#{BASE_PATH}/#{path}"
      else
        "#{HOST_URL}/#{BASE_PATH}/#{path}?#{additional_params.to_query}"
      end
  end
end