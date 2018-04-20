class Task < ApplicationRecord
  belongs_to :group
  belongs_to :user, optional: true
  belongs_to :crop, optional: true
end
