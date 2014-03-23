class Task < ActiveRecord::Base
	belongs_to :user

	validates :user_id, presence: true
	validates :title, presence: true

	scope :open, -> { where(closed: false) }
	scope :today, -> { open.where(['created_at < ?', Time.now])}

end
