class Task < ActiveRecord::Base
	belongs_to :user

	default_scope -> { order('created_at ASC') }

	validates :user_id, presence: true
	validates :title, presence: true

	scope :closed, -> { where(closed: true) }

	def self.day(day = DateTime.now)
		where("created_at <= ? AND (closed_at > ? OR closed IS false)", day.end_of_day.utc, day.beginning_of_day.utc)
	end

	def started?
		!self.started_at.nil?
	end

	def started=(value)
	    if value
	      self.started_at = DateTime.now
	    else
	      self.started_at = nil
	    end
	  end

	def next
		user.tasks.where("id > ?", id).order("id ASC").first
	end

	def prev
		user.tasks.where("id < ?", id).order("id DESC").first
	end

end
