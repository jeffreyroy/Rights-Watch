require 'json'
require 'open-uri'
require 'pp'



# Construct the URL we'll be calling
request_uri = 'https://www.courtlistener.com/api/rest/v3/schools/'
request_query = '?name=McMurry%20College'
url = "#{request_uri}#{request_query}"

# Actually fetch the contents of the remote URL as a String.
buffer = open(url).read

# Sample JSON response from fake API endpoint (a simple app running on my machine), but you can easily build it. Credit goes to Michael Hartl for the stellar "Build Twitter in Rails" tutorial:
#
# http://ruby.railstutorial.org/ruby-on-rails-tutorial-book
#
# Output after running it through http://jsonviewer.net to make it more readable.
# ['0'] (
# |    id =  2
# |    name =  "Example User"
# |    email =  "example@railstutorial.org"
# |    created_at =  "2013-12-11T06:09:06.866Z"
# |    updated_at =  "2013-12-11T06:09:06.866Z"
#      # ... and more
# |    )
# ['1'] (
# |    id =  4
# |    name =  "Example User 2"
# |    email =  "example@railstutorial.org"
# |    created_at =  "2013-12-11T06:09:06.866Z"
# |    updated_at =  "2013-12-11T06:09:06.866Z"
#      # ... and more
# |    )

# Convert the String response into a plain old Ruby array. It is faster and saves you time compared to the standard Ruby libraries too.
result_hash = JSON.parse(buffer)

result_array = result_hash["results"]

p result_array.length

pp result_array

pp result_array.map { |result| result["name"]}



# An example of how to take a random sample of elements from an array. Pass the number of elements you want into .sample() method. It's probably a better idea for the server to limit the results before sending, but you can use basic Ruby skills to trim & modify the data however you'd like.
# result = result.sample(5)

# Loop through each of the elements in the 'result' Array & print some of their attributes.
# result.each do |user|
#   puts "#{user['id']}\t#{user['name']}\t#{user['email']}"
#   puts "Registered: #{user['created_at']}\n\n"
# end


# Expected output in this format:
# Uncomment the next line to output the data inside the 5 elements returned from the JSON call. Google 'Ruby pp gem'.

# pp result

# 14  Kari Lynch  example-12@railstutorial.org
# Registered: 2013-12-11T06:09:08.231Z

# 20  Dr. Josh Bergstrom  example-18@railstutorial.org
# Registered: 2013-12-11T06:09:08.788Z

# 24  Haley Walter  example-22@railstutorial.org
# Registered: 2013-12-11T06:09:09.157Z

# 17  Ozella Barton example-15@railstutorial.org
# Registered: 2013-12-11T06:09:08.511Z

# 13  Mandy Reynolds  example-11@railstutorial.org
# Registered: 2013-12-11T06:09:08.138Z


