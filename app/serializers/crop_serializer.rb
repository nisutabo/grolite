class CropSerializer < ActiveModel::Serializer
  attributes :id, :name, :scientific_name, :crop_group, :temp_night, :dli, :sun_hours, :dth, :temp_day, :maxhumidity, :minhumidity, :ph, :ec

end
