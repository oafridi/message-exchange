get '/' do
  if logged_in?
    @user = User.find(session[:user_id])
    redirect "/users/#{@user.email}"
  else
    @tweets = Update.includes(:user).limit(20).order(updated_at: :desc)
    erb :index
  end
end

get '/users/signup' do
  erb :signup
end

post '/users' do
  @user = User.new(params)

  if @user.save
    session[:user_id] = @user.id
    redirect "/users/#{@user.email}"
  else
    erb :index
  end
end

get '/users/:email' do
  @user = User.find_by(email: params[:email])
  @tweets = Update.where(user_id: @user.id)

  erb :profile
end


