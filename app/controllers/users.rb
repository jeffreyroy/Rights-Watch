# Create new user
get '/users/new' do
  erb :'users/new'
end

# Submit new user form
post '/users' do
  if params[:password_confirmation] == params[:user][:password]
    @user = User.new(params[:user])
    if @user.save
      session[:id] = @user.id
      redirect "/"
    else
      @errors = @user.errors.full_messages
      erb :'/users/new'
    end
  else
    @errors = ['Passwords do not match!']
    erb :'/users/new'
  end
end

# Show user page
get '/users/:id' do
  @user = User.find(params[:id])
  erb :"users/show"
end

# Edit user
get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :'users/edit'
end

# Update user
put '/users/:id' do
  user = User.find(params[:id])
  user.update_attributes(params[:user])
  if params[:password]
    if params[:password_confirmation] == params[:password]
      user.update_attributes(params[:password])
    else
      @errors = ['Passwords do not match!']
      erb :'/users/edit'
    end
  end
  redirect "/users/#{params[:id]}/users/#{params[:id]}"
end

# Delete user
delete '/users/:id' do
  user = User.find(params[:id])
  user.destroy
  redirect '/'
end
