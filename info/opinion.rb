require 'json'
require 'open-uri'
require 'pp'
require 'httparty'

# class CourtListener
  CL_URL = 'https://www.courtlistener.com/api/rest/v3/'

# Construct the URL we'll be calling
# request_uri = 'https://www.courtlistener.com/api/rest/v3/clusters/'
# request_query = "?federal_cite_one=410%20U.S.%20113"
# url = "#{request_uri}#{request_query}"

# Actually fetch the contents of the remote URL as a String.
# buffer = open(url).read

response = HTTParty.get(request_uri)

# end


