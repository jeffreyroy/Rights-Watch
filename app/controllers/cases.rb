get "/cases" do
  @court_listener ||= CourtListener.new
  erb :'cases/index'
end

get "/cases/new" do
  @issues=Issue.all
  erb :'cases/new'
end

get "/issues/:issue_id/cases/new" do
  issue = Issue.find(params[:issue_id])
  if request.xhr?
    erb :'cases/_form', layout: false, locals: { issue: issue }
  else
    erb :'cases/new'
  end
end

post "/issues/:issue_id/cases" do
  @issue = Issue.find(params[:issue_id])
  # Get parameters
  p = params[:plaintiff]
  d = params[:defendant]
  vol = params[:volume]
  pg = params[:page]
  # Construct case info from parameters, if they exist
  name = (p != "" && d != "") ? p + ' v. ' + d : nil
  citation = (vol != 0 && pg != 0) ? vol.to_s + params[:reporter] + pg.to_s : nil
  date = params[:date]
  @case = Case.new(issue_id: @issue.id, name: name, cite1: citation, date_decided: date)
  if @case.save
    if request.xhr?
      erb :"/cases/_button", layout: false, locals: { cur_case: @case }
    else
      redirect "/issues/#{@issue.id}"
    end
  else
    if !request.xhr?
      @issues=Issue.all
      erb :"/cases/new"
    end
  end
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
    redirect "/issues/#{issue.id}"
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
