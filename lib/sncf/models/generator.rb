module Sncf
  module Models
    MODEL_NAMES = %w[Station AdministrativeRegion]
    MODEL_ATTRIBUTES = {
      'Station' => [:id, :coord, :quality, :name, :label, :timezone, :administrative_regions],
      'AdministrativeRegion' => [:insee, :level, :coord, :name, :label, :id, :zip_code]
    }

    def self.generate_models
      Sncf::Models::MODEL_NAMES.each do |klass_name|
        klass_vars  = Sncf::Models::MODEL_ATTRIBUTES[klass_name.to_s]
        klass       = generate_class klass_vars

        const_set klass_name, klass
      end
    end

    def self.generate_class(klass_vars)
      Class.new do
        klass_vars.each do |field|
          define_method field.intern do
            instance_variable_get("@#{field}")
          end
          define_method "#{field}=".intern do |arg|
            instance_variable_set("@#{field}", arg)
          end
        end
        define_method :initialize do |args|
          klass_vars.each do |field|
            instance_variable_set("@#{field}", args[field])
          end
        end
      end
    end
  end
end
