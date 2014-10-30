require 'spec_helper'

describe User do
  before(:each) do
    User.delete_all
  end

  let(:params) { {     email: "test@gmail.com",
                    password: "hello",
                        name: "eddie" } }
  let(:nameless) { {   email: "test@gmail.com",
                    password: "hello",
                        name: "" } }
  let(:sample_user) { User.create(params) }

  describe "User.create" do
    it "should add a user to the database" do
      expect {User.create(params)}.to change {User.count}.by(1)
    end

  end

  describe User do
    it "should validate format of email" do
      should_not allow_value("andy").for(:email)
    end

    it "should validate uniqueness of email" do
      should validate_uniqueness_of(:email)
    end

    it "should validate presence of name" do
      should validate_presence_of(:name)
    end

    it "should respond to name, password, email" do
      [:name, :password, :email].each do |method|
        should respond_to method
      end
    end
  end
end
