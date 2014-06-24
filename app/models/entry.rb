class Entry < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy, :as => :commentable
	default_scope -> { order('created_at DESC') }
	validates :title, presence: true
	validates :body, presence: true
	validates :user_id, presence: true
end
