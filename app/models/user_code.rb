class UserCode < ApplicationRecord
  belongs_to :user

  validates :programming_language, presence: true
  validates :code_content, presence: true 
  validates :user_id, presence: true
end
