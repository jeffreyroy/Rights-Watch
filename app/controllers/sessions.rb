# Create session
get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  @user = User.find_by_email(params[:email])
  if @user && @user.password == params[:password]
    session[:id] = @user.id
    redirect '/'
  else
    @errors=["No match found for email and password."]
    erb :'/sessions/new'
  end
end

# End session
delete '/sessions' do
  session[:id] = nil
  redirect '/'
end
