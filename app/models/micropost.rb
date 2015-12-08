class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) } # Ordering the post with default_scope
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 500 } #content not longer then 500 characters
end
