post '/signin' do
  @user = User.find_by(email: params[:email])

  if @user && @user == @user.authenticate(params)
    session[:user_id] = @user.id
    redirect "/users/#{params[:email]}"
  else
    flash[:error] = "Authentication failed!"
    erb :index
  end
end

get '/signout' do
  session[:user_id] = nil

  redirect "/"
end
