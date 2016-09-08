class User < ActiveRecord::Base
  include BCrypt
  # Remember to create a migration!
  has_and_belongs_to_many :issues
  validates :user_name, presence: true
  validates :email, presence: true

  # Password getter and setter
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  # Following issues
  def follow(issue)
    if !following?(issue)
      issues << issue
    end
  end

  def following?(issue)
    return true if issues.include?(issue)
    false
  end

end
