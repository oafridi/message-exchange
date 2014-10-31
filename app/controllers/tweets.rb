def authenticate!
  @user = User.find(session[:user_id]) if session[:user_id]
  redirect '/users/signup' if @user.nil?
end

before '/tweet*' do
  authenticate!
end

get '/tweet/new' do
  @tweet = @user.updates.new( body: params[:body] )
  erb :"tweets/new"
end

post '/tweet' do
  @tweet = @user.updates.new( body: params[:body] )
  if @tweet.save
    flash[:success] = "Tweet Posted!"
    redirect "/profile"
  else
    flash[:errors] = "Format of the tweet was wrong."
    erb :"tweets/new"
  end
end
get '/tweet' do
  redirect "/tweet/new"
end
