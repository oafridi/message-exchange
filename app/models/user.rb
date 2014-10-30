class User < ActiveRecord::Base
  has_many :updates
  validates :email, :uniqueness => true
  validates :email, :format => {with: /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/}
end
