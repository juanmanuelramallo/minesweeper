class User < ApplicationRecord
  has_many :games

  validate :uuid, uniqueness: true
end
