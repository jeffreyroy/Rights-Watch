class Opinion < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :case
  belongs_to :justice
  # Need to confirm that this works:
  delegate :issue, to: :case

end
