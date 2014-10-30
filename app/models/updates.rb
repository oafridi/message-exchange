class Updates < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  validates :body, length: {minimum: 1, maximum: 140}
end
