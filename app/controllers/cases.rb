get "/cases" do
  @court_listener ||= CourtListener.new
  erb :'cases/index'
end

get "/cases/new" do
  @issues=Issue.all
  erb :'cases/new'
end

post "/cases" do
  issue = Issue.find_by(name: params[:issue])
  # Get parameters
  p = params[:plaintiff]
  d = params[:defendant]
  vol = params[:volume]
  pg = params[:page]
  # Construct case info from parameters, if they exist
  name = (p != "" && d != "") ? p + ' v. ' + d : nil
  citation = (vol != 0 && pg != 0) ? vol.to_s + params[:reporter] + pg.to_s : nil

  date = params[:date]
  @case = Case.new(issue_id: issue.id, name: name, cite1: citation, date_decided: date)
  if @case.save
    redirect "/cases"
  else
    @issues=Issue.all
    erb :"/cases/new"
  end
end

# Display case
get "/cases/:id" do
  @case = Case.find(params[:id])
  erb :'cases/show'
end
