require 'spec_helper'

describe "UserController" do
  before(:all) do
    User.delete_all
    Update.delete_all
  end

  let(:user_params) { {     email: "test@gmail.com",
                    password: "hello",
                        name: "eddie" } }
  let(:sample_user) { User.create(user_params) }
  let(:session) { {user_id: nil} }

  describe "get /" do
    it "should return status code 200" do
      get "/"
      expect(last_response.status).to be(200)
    end
    it "should show a login form if user is *not* authenticated" do
      get "/"
      expect(last_response.body).to include('type="password"')
    end
    it "should show username if user is authenticated" do
      session[:user_id] = sample_user.user_id
      get "/"
      expect(last_response.body).to include("#{sample_user.email}")
    end
  end
end
