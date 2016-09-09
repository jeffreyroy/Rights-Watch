class Case < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :issue
  has_many :opinions
  has_many :justices, through: :opinions

  validates :name, presence: true
  validates :date_decided, presence: true
  validates :cite1, presence: true

  # Return full Bluebook citation
  def full_citation
    "#{name}, #{cite1} (#{date_decided.year})"
  end

  def full_text
    courtlistener = CourtListener.new
  end

  # Get case info from CourtListener
  def cl_hash
    if @cl_hash
      return @cl_hash
    else
      courtlistener = CourtListener.new
      @cl_hash = courtlistener.case_by_cite(cite1)
    end
  end
  # Return text of main opinion

  def opinion_url
    cl_hash["sub_opinions"][0]
  end

  def full_text
    courtlistener = CourtListener.new
    courtlistener.opinion_text_by_url(opinion_url)
  end

  # Return five most recent citations as courtlistener urls
  def recent_citations
    courtlistener = CourtListener.new
    citations = courtlistener.citing_opinions(cite1)
    citation_list = citations[0..4].map do |citation|
      data_hash = courtlistener.case_data_by_opinion(citation["citing_opinion"])
      c = CLOpinion.new(data_hash)
      c.id = courtlistener.id_from_url(citation["citing_opinion"])
      c
    end
  end
end
