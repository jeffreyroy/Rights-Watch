# Show citation page
get '/issues/:issue_id/citations/:id' do
  @issue = Issue.find(params[:issue_id])
  @citation = CLOpinion.new(id: params[:id])
  @citation.init_from_id
  erb :"citations/show"
end
