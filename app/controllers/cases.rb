get "/cases" do
  @court_listener = CourtListener.new
  erb :cases
end
