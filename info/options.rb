require 'json'
require 'open-uri'
require 'pp'
require 'httparty'

# class Opinion

# Construct the URL we'll be calling
request_uri = 'https://www.courtlistener.com/api/rest/v3/opinions-cited/'
request_query = "?federal_cite_one=410%20U.S.%20113"
url = "#{request_uri}#{request_query}"

# Actually fetch the contents of the remote URL as a String.
# buffer = open(url).read

response = HTTParty.options(request_uri)

pp response

# result_hash = JSON.parse(buffer)

# result_array = result_hash["results"]

# p result_array.length

# pp result_array

# pp result_array.map { |result| result["case_name"]}

# end


