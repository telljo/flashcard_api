class UserSerializer < ActiveModel::Serializer
  attributes :id, :email_address, :created_at, :updated_at
end
