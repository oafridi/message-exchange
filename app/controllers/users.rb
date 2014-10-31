get '/' do
  if logged_in?
    @user = User.find(session[:user_id])
    # get tweets from following
    #@tweets = Update.limit(20).order(updated_at: :desc).where(user_id: @user.following_ids )
    @tweets = Update.limit(20).order(updated_at: :desc).where('user_id in (?) OR user_id = ?', @user.following_ids, @user.id )
    #redirect "/users/#{@user.email}"
    erb :index
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
    email("Welcome to twitter", :welcome_email)
    redirect "/users/#{@user.email}"
  else
    erb :index
  end
end

get '/users/:email' do
  @user = User.includes(:updates).find_by(email: params[:email])

  erb :profile
end

post '/follow' do
  @current_user = User.find(session[:user_id])
  @user = User.includes(:updates).find(params[:user_id])
  @current_user.following << @user

  if @current_user.save
    flash[:success] = "Now following #{@user.email}!"
    redirect "/users/#{@user.email}"
  else
    flash[:errors] = "Something went wrong!"
    redirect "/users/#{@user.email}"
  end
end

post '/unfollow' do
  @current_user = User.find(session[:user_id])
  @user = User.includes(:updates).find(params[:user_id])
  relation = Relationship.where(follower_id: @current_user.id).find_by(followed_id: @user.id)

  if relation.destroy
    flash[:success] = "No longer following #{@user.email}!"
    redirect "/users/#{@user.email}"
  else
    flash[:errors] = "Something went wrong!"
    redirect "/users/#{@user.email}"
  end
end
