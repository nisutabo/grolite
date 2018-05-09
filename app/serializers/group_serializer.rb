class GroupSerializer < ActiveModel::Serializer
  attributes :id, :seed_date, :harvest_date, :germination_days, :propagation_days, :production_days, :propagation_date, :production_date, :harvest_date, :expected_harvest_lbs, :actual_harvest_lbs, :harvested, :user_id, :crop_id, :location, :status, :trays, :crop_name, :crop_group, :scientific_name
end
