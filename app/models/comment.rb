class Comment < ActiveRecord::Base
	belongs_to :commentable, :polymorphic => true
	default_scope -> { order('created_at ASC') }
	validates :content, presence: true
	validates :commentable_id, presence: true
end
