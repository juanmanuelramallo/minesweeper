class UserSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :created_at, :updated_at
  has_many :games
end
