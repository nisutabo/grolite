class Crop < ApplicationRecord
  has_many :groups
  has_many :tasks, through: :groups
end
