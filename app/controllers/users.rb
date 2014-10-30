get '/' do
  # if user is login go to profile page else login page
  # if current_user
  #   erb :profile
  # else
  #   erb :login
  # end

  erb :index
end

get '/users/signup' do
  erb :signup
end

post '/users' do
  @user = User.create(params)

  if @user.save
    session[:user_id] = @user.id
    redirect "/users/#{@user.email}"
  else
    erb :index
  end
end

get '/users/:email' do
  @user = User.find_by(email: params[:email])
  @tweets = Update.find_by(user_id: @user.id)

  erb :profile
end

get '/signout' do
  erb :index
end
