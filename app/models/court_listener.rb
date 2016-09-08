
# CourtListener class communicates with the courtlistener api
class CourtListener
  CL_URL = 'https://www.courtlistener.com/api/rest/v3/'
  TOKEN = ENV['SECRET_TOKEN']

  # Perform an authorized get request
  def get(request_url)
    # Print all requests for testing purposes
    p "*"*100
    p request_url
    p self.class::TOKEN
    HTTParty.get(request_url, headers: {"Authorization" => "Token #{self.class::TOKEN}"})
    # HTTParty.get(request_url)
  end

  # Perform query on endpoint
  def query(endpoint, query)
    request_url = CL_URL + endpoint + "/?" + query
    get(request_url)
  end

  # Extract id from end of url, i.e.  ../opinions/4030562/
  def id_from_url(url)
    url.split("/")[-1]
  end

  # Perform search for case and return first found, parsed into a hash
  def case_by_cite(cite)
    full_result = query("clusters", { "federal_cite_one"=>cite }.to_query)
    p full_result
    full_result["results"][0]
  end

  # All opinions within a single case
  def opinions_by_cite(cite)
    case_by_cite(cite)["sub_opinions"]
  end

  # Perform search for person and return first found, parsed into a hash
  def person_by_name(first_name, last_name)
    full_result = query("people", { "name_first"=>first_name, "name_last"=>last_name }.to_query)
    full_result["results"][0]
  end

  # Full text by opinion
  def opinion_text_by_url(request_url)
    full_result = get(request_url)
    full_result["html_with_citations"]
  end

  # ?cited_opinion__id=<caseid>
  def citing_opinions(cite)
    cur_case = case_by_cite(cite)
    cur_opinion = cur_case["sub_opinions"][0]
    opinion_id = id_from_url(cur_opinion)
    full_result = query("opinions-cited", "fields=citing_opinion&cited_opinion__id=#{opinion_id}")
    full_result["results"]
  end

  def case_by_opinion(opinion_url)
    opinion_hash = get(opinion_url)
    cluster_url = opinion_hash["cluster"]
  end

  def case_data_by_opinion(opinion_url)
    opinion_hash = get(opinion_url)
    full_text = opinion_hash["plain_text"]
    cluster_url = opinion_hash["cluster"]
    cluster_hash = get(cluster_url)
    name = cluster_hash["case_name"]
    cite = cluster_hash["federal_cite_one"]
    date_decided = cluster_hash["date_filed"]
    data_hash = {
      name: name,
      cite: cite,
      date_decided: date_decided,
      full_text: full_text
    }
  end

  def full_text_by_opinion(opinion_url)
    opinion_hash = get(opinion_url)
    opinion_hash["plain_text"]
  end

end
