class Case < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :issue
  has_many :opinions
  has_many :justices, through: :opinions

  validates :name, presence: true
  validates :date_decided, presence: true
  validates :cite1, presence: true


  def full_citation
    "#{name}, #{cite1} (#{date_decided.year})"
  end
end
