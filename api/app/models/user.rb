class User < ApplicationRecord
  has_many :games

  validates :uuid, presence: true, uniqueness: true

  before_validation :generate_uuid, on: :create

  private

  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
