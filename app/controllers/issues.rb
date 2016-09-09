# List of all issues
get "/issues" do
  erb :'issues/index'
end

#Add new issue
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
    if request.xhr?
      erb :"/issues/_button", layout: false, locals: { issue: @issue }
    else
      redirect "/issues"
    end
  else
    erb :"/issues/new"
  end
end

# Follow issue
post "/issues/:id/follow" do
  # Get parameters
  @issue = Issue.find(params[:id])
  @user = current_user
  if @user
    if @user.following?(@issue)
      @errors=["You're already following that issue"]
      erb :'/issues'
    else
      @user.issues << @issue
      redirect "/issues"
    end
  end
end

# Unfollow issue
post "/issues/:id/unfollow" do
  # Get parameters
  @issue = Issue.find(params[:id])
  @user = current_user
  if @user
    if !@user.following?(@issue)
      @errors=["You're not following that issue"]
      erb :'/issues'
    else
      @user.issues.delete(@issue)
      redirect "/issues"
    end
  end
end

# Display issue
get "/issues/:id" do
  @issue = Issue.find(params[:id])
  erb :'issues/show'
end

# Display issue with recent cases
post "/issues/:issue_id/cases/:case_id" do
  @issue = Issue.find(params[:issue_id])
  @case = Case.find(params[:case_id])
  erb :'issues/show'
end
