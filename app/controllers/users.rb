get '/' do
  # if user is login go to profile page else login page
  # if current_user
  #   erb :profile
  # else
  #   erb :login
  # end

  erb :index
end

get '/signup' do
  erb :signup
end

post '/profile' do
  redirect '/profile'
end

get '/profile' do
  @tweets = ["one", "two", "three"]
  erb :profile
end

get '/signout' do
  erb :index
end
