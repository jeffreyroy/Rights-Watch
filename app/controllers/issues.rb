get "/issues" do
  erb :'issues/index'
end

get "/issues/new" do

  if request.xhr?
    erb :'issues/_form', layout: false
  else
    erb :'issues/new'
  end
end

post "/issues" do
  # Get parameters
  @issue = Issue.new(name: params[:name])
  if @issue.save
    redirect "/issues"
  else
    erb :"/issues/new"
  end
end
