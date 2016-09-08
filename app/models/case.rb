require_relative 'cl_opinion'

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

  # Return five most recent citations as courtlistener urls
  def recent_citations
    courtlistener = CourtListener.new
    citations = courtlistener.citing_opinions(cite1)
    citation_list = citations[0..4].map do |citation|
      # citation["citing_opinion"]
      # courtlistener.case_by_opinion(citation["citing_opinion"])
    end
    data_hash = courtlistener.case_data_by_opinion(citations[0]["citing_opinion"])
    # CLOpinion.new(data_hash)

  end
end
