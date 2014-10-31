require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :updates
  has_many :my_followings, class_name: "Relationship", foreign_key: :follower_id
  has_many :my_followers, class_name: "Relationship", foreign_key: :followed_id

  has_many :following, through: :my_followings, :source => :followed
  has_many :followers, through: :my_followers

  validates :email, :uniqueness => true
  validates :email, :format => {with: /[a-zA-Z0-9_.+]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9.]/}
  validates :name, :presence => true

  def password
    @password ||= Password.new(password_hash)\
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
