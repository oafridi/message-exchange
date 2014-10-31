require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :updates
  validates :email, :uniqueness => true
  validates :email, :format => {with: /[a-zA-Z0-9_.+]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9.]/}
  validates :name, :presence => true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(params)
    user = User.find_by_email(params[:email])

    (user && user.password == params[:password]) ? user : nil
  end
end
