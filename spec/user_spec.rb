require 'spec_helper'

describe 'User' do
  before(:all) do
    User.delete_all
  end

  let(:params) { { email: "test@gmail.com", password: "hello"} }
  describe "User.create" do
    it "should add a user to the database" do
      expect {User.create(params)}.to change {User.count}.by(1)
    end

    it "should prevent a user with the same email from being created" do
      expect {User.create(params)}.to_not change {User.count}.by(1)
    end

  end
end
