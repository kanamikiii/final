class User < ActiveRecord::Base
  	before_save { email.downcase! }

  	# validate username
  	validates :name,  presence: true, length: { maximum: 50 }
  	
  	# validate email
  	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	# disallow multiple dots in email address
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
   		uniqueness: { case_sensitive: false }
   	
   	# validate password
   	has_secure_password
   	validates :password, length: { minimum: 6 }

end
