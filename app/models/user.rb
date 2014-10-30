require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :updates
  validates :email, :uniqueness => true
  validates :email, :format => {with: /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/}

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
