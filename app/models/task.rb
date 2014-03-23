class Task < ActiveRecord::Base
	belongs_to :user

	default_scope -> { order('created_at DESC') }

	validates :user_id, presence: true
	validates :title, presence: true

	scope :closed, -> { where(closed: true) }

	def self.today(day = DateTime.now)
		where("created_at <= ? AND (closed_at > ? OR closed IS false)", day.end_of_day, day.beginning_of_day)
	end

end
