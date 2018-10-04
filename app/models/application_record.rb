class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def time(time)
  	hour = time.hour.to_s 
  	min = time.min.to_s
  	if hour.length < 2
  		hour = '0' + time.hour.to_s
  	end
  	if min.to_s.length < 2
  		min = '0' + time.min.to_s
  	end 
  	hour + ':' + min
  end
end
