class Case < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :issue
  has_many :opinions
  has_many :justices, through: :opinions

  def full_citation
    "#{name}, #{cite1} (#{date_decided.year})"
  end
end
