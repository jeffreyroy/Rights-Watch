class Justice < ActiveRecord::Base
  # Remember to create a migration!
  has_many :opinions
  has_many :cases, through: :opinions
  has_many :issues, through: :cases

  def full_name
  	"#{first_name} #{last_name}"
  end
  
end
