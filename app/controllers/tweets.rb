get '/tweet/new' do
  erb :"tweets/new"
end

post '/tweet' do
  flash[:success] = "Tweet Posted!"
  redirect "/profile"
end
