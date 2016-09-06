get "/cases" do
  @court_listener ||= CourtListener.new
  erb :'cases/index'
end

get "/cases/new" do
  @issues=Issue.all
  erb :'cases/new'
end

post "/cases" do
  issue_id = Issue.find_by(name: params[:issue])
  name = params[:plaintiff] + ' v. ' + params[:defendant]
  citation = params[:citation]
  date = params[:date]
  @case = Case.new(issue_id: issue_id, name: name, cite1: citation, date_decided: date)
  if @case.save
    redirect "/cases"
  else
    erb :"/cases/new"
  end
end
