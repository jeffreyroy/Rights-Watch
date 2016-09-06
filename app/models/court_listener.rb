
# CourtListener class communicates with the courtlistener api
class CourtListener
  CL_URL = 'https://www.courtlistener.com/api/rest/v3/'
  TOKEN = ENV['SECRET_TOKEN']

  # Perform a GET request on an endpoint using a hash for query
  def get(endpoint, query_hash)
    request_url = CL_URL + endpoint + "/?" + query_hash.to_query
    p request_url
    HTTParty.get(request_url, headers: {"Authorization:" => "Token #{TOKEN}"})
  end

  # Perform search for case and return first found, parsed into a hash
  def case_by_cite(cite)
    full_result = get("clusters", { "federal_cite_one"=>cite })
    full_result["results"][0]
  end

  def opinions_by_cite(cite)
    case_by_cite(cite)["sub_opinions"]
  end

  # Perform search for person and return first found, parsed into a hash
  def person_by_name(first_name, last_name)
    full_result = get("people", { "name_first"=>first_name, "name_last"=>last_name })
    full_result["results"][0]
  end

  def opinion_text_by_url(request_url)
    full_result = HTTParty.get(request_url)
    full_result["html_with_citations"]
  end


end
