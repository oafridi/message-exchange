require 'spec_helper'

describe 'User' do
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

    it "should prevent a user with the same email from being created" do
      User.create(params)
      expect {User.create(params)}.to_not change {User.count}.by(1)
    end

    it "should prevent a user without a name from being created" do
      expect {User.create(nameless)}.to_not change {User.count}.by(1)
    end
  end

  describe User do
    it "should respond to name, password, email" do
      [:name, :password, :email].each do |method|
        should respond_to method
      end
    end
  end
end
