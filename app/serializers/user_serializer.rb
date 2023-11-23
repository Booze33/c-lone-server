class UserSerializer < ActiveModel::Serializer
  attributes :id, :programming_language, :code_content, :created_at, :updated_at
  has_many :user_codes
end
