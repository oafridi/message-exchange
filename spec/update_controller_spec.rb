require 'spec_helper'

describe "UpdateController" do
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

  describe "get '/tweet/new'" do
    it "should return status code 200" do
      get '/tweet/new'
      expect(last_response.status).to be(200)
    end
    it "should show a form to create a tweet if user is authenticated" do
      get '/tweet/new'
      expect(last_response.body).to include('name="body"')
    end
    it "should show username if user is authenticated" do
      session[:user_id] = sample_user.user_id
      get '/tweet/new'
      expect(last_response.body).to include("#{sample_user.email}")
    end
  end

  describe "post '/tweet/new'" do
    it "should create a tweet in the database" do
      expect {
        post '/tweet/new', :params => { body: sample_update_content }
      }.to change {Update.count}.by(1)
    end
  end

end
