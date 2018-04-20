class User < ApplicationRecord
  has_many :groups
  has_many :tasks, through: :groups

  has_secure_password
end
