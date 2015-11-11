class User < ActiveRecord::Base
  attr_accessor :remember_token

  before_save { email.downcase! }                               # Sets the user's email address to a lowercase version
		validates :name, presence: true, length: {maximum: 50}      # @user.name = " " 		(pass with max parameter)
		VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i    # full regex
		validates :email, presence: true, length: {maximum: 255},   # @user.email = " " 	(pass with max parameter)
				  format: { with: VALID_EMAIL_REGEX },      # Indicated in Ruby name format all capital letter
				  uniqueness: { case_sensitive: false }     # Validating the uniqueness of email addresses which is false
				  has_secure_password                       # required password_digest attribute
				  validates :password, length: {minimum: 6}

  #Returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #Returns true of the given token matchs the digest
  def authenticate?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  #Forgets a user
  def forget  # Adding a forget method to the User model
    update_attribute(:remember_digest, nil)
  end

  #Returns true if the given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
