get "/" do
  p "*"*50
  p CourtListener::AUTH_TOKEN
	erb :index
end
