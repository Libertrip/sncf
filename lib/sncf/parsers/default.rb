module Sncf
  module Parsers
    class Default
      def initialize(api_response)
        @api_response = api_response
      end

      protected

      def create_model(model_name, attributes)
        Object.const_get("Sncf::Models::#{model_name}").new attributes
      end
    end
  end
end
