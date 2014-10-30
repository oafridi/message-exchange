require 'spec_helper'

describe 'Update' do
  before(:each) do
    Update.delete_all
  end

  let(:user_params) { {     email: "test@gmail.com",
                    password: "hello",
                        name: "eddie" } }
  let(:sample_user) { User.create(user_params) }
  let(:valid_tweet_params) { {     body: "Hello my name is eddie.",
                    user_id: sample_user.id } }
  let(:not_valid_tweet_params) { {   body: "",
                    user_id: sample_user.id } }

  describe "Update.create" do
    it "should add a Update to the database" do
      expect {Update.create(valid_tweet_params)}.to change {Update.count}.by(1)
    end

    it "should prevent a Update without a name from being created" do
      expect {Update.create(not_valid_tweet_params)}.to_not change {Update.count}.by(1)
    end
  end

  describe Update do
    it "should respond to body and user" do
      [:body, :user].each do |method|
        should respond_to method
      end
    end
  end
end
