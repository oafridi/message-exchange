class Update < ActiveRecord::Base
  belongs_to :user
  validates :body, length: {minimum: 1, maximum: 140}
end
