class User < ActiveRecord::Base
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
end
