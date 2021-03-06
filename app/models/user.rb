class User < ActiveRecord::Base
	has_many :tasks

	validates :name, presence: true, uniqueness: true

	def to_param
	  name.parameterize
	end

	def day_started?
		if self.last_day.nil?
      return false
    else
      self.last_day < DateTime.now.in_time_zone(Time.zone).beginning_of_day ? false : true
    end
	end

  def day_started=(value)
    if value
      self.last_day = DateTime.now
    else
      self.last_day = nil
    end
  end
	
end
