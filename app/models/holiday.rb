# == Schema Information
#
# Table name: holidays
#
#  id         :integer          not null, primary key
#  status     :string
#  start      :datetime
#  end        :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Holiday < ActiveRecord::Base
  validates_presence_of :user
  validate :date_is_datetime?
  validate :start_before_end?
  validate :start_before_today?
  validate :to_far_in_the_future?
  validate :sufficient_leave_left?
  belongs_to :user

  def sum_duration
  	duration_this_year + duration_next_year
  end

  def end_of_this_year
    Date.today.change(day: 31, month: 12)
  end

  def start_of_next_year
    Date.today.change(year: Date.today.year + 1, day: 1, month: 1)
  end

  def duration_this_year
    
    if (self.start.year <= (Date.today.year))
      if (self.end.year <= (Date.today.year))
        (self.end - self.start).to_i/1.day + 1
      else
        (end_of_this_year - self.start.to_date).to_i + 1
      end
    else
      0
    end
  end

  def duration_next_year
    if (self.start.year <= (Date.today.year))
      if (self.end.year <= (Date.today.year))
        0
      else
      (self.end.to_date - start_of_next_year).to_i + 1
      end
    else
      (self.end - self.start).to_i/1.day + 1
    end
  end

  private

  def date_is_datetime?
  	if (self.start.nil?)
  		errors.add(:start, "must be a valid date!")
  		self.start = Date.today
  	end
  	if (self.end.nil?)
  		errors.add(:end, "must be a valid date!")
  		self.end = Date.today+1
  	end
  end

  def start_before_end?
  	if !(self.end > self.start)
  	  errors.add(:start, "must be before #{self.end}")
  	end
  end

  def start_before_today?
  	if !(Date.today <= self.start.to_date)
  		errors.add(:start, "must be after #{Date.today}")
  	end
  end

  def to_far_in_the_future?
    if !(self.end.year < Date.today.year + 2)
      errors.add(:Holiday, "is to far in the future")
    end
  end

  def sufficient_leave_left?
  	#for tests, find out why this is necessary, plx
  	if self.user
  	  if !(self.user.remaining_leave_this_year >= duration_this_year)
  	    errors.add(:Not, "enough leave for this year left!")
	  end
	  if !(self.user.remaining_leave_next_year >= duration_next_year)
	    errors.add(:Not, "enough leave for next year left")
	  end
	  #if !(self.user.remaining_leave_this_year + self.user.remaining_next_year >= sum_duration)
	  #    errors.add(:Not, "enough leave left")
	  #end
	end
  end
end
