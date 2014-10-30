require 'spec_helper'

describe "UserController" do
  before(:each) do
    User.delete_all
    Update.delete_all
  end

  let(:user_params) { {     email: "test@gmail.com",
                         password: "hello",
                             name: "eddie" } }
  let(:sample_user) { User.create(user_params) }
  let(:sample_update_content) { {body: "Hello my name is eddie.",
                    user_id: sample_user.id } }
  let(:sample_update) { Update.create(sample_update_content) }
  let(:session) { {user_id: nil} }

  describe "get '/'" do
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

  describe "post '/signup'" do
    it "for valid user credentials should set session[:user_id]" do
      post "/signup", :params => { email: user_params[:email],
                                  password: user_params[:password] }
      should set_session(:user_id)
    end
    it "for invalid user credentials should not set session[:user_id]" do
      post "/signup", :params => { email: "andy",
                                  password: "incorrect" }
      should_not set_session(:user_id)
    end
  end

  describe "post '/login'" do
    it "for valid user credentials should set session[:user_id]" do
      post "/login", :params => { email: user_params[:email],
                                  password: user_params[:password] }
      should set_session(:user_id)
    end
    it "for invalid user credentials should not set session[:user_id]" do
      post "/login", :params => { email: user_params[:email],
                                  password: "incorrect" }
      should_not set_session(:user_id)
    end
  end

  describe "get '/users/:email'" do
    it "should return status code 200" do
      get "/users/#{sample_user.email}"
      expect(last_response.status).to be(200)
    end

    it "should show updates for user" do
      get "/users/#{sample_user.email}"
      expect(last_response.body).to include(sample_update.body)
    end

    it "should show count of updates for user" do
      get "/users/#{sample_user.email}"
      expect(last_response.body).to include("count")
    end
  end
end
