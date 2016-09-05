class Issue < ActiveRecord::Base
  # Remember to create a migration!
  has_many :cases
  has_many :opinions, through: :cases
  has_many :justices, through: :opinions

end
