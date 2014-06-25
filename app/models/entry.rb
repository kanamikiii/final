class Entry < ActiveRecord::Base
	before_create :create_remember_token
	belongs_to :user
	has_many :comments, dependent: :destroy, :as => :commentable
	default_scope -> { order('created_at DESC') }
	validates :title, presence: true
	validates :body, presence: true
	validates :user_id, presence: true

	def Entry.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

  	def Entry.digest(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end

  	def self.from_users_followed_by(user)
    	followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

  private

    def create_remember_token
      	self.remember_token = Entry.digest(Entry.new_remember_token)
    end
end
