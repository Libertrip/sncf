require 'sncf/version'
require 'sncf/api_client'
require 'sncf/api_response'
require "sncf/models/generator"
require "sncf/parsers/default"
require "sncf/parsers/places"

module Sncf
end

Sncf::Models.generate_models
