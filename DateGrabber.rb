require 'date'
require './Term'

class DateGrabber

	attr_reader :right_term
	
	def initialize (date=Date.today)
		@date = date
		
		@year = date.year()
		@year -= 1 if(@date.month() < 9)
		
		@right_term = determine_term()
	end
	
	def determine_term()
		(1..4).each{ |i|
			
			guess_term = Term.get_term(@year.to_s + i.to_s)
			
			if(i == 1)
				return nil if guess_term.start > @date
			end 
			
			if(@date >= guess_term.start && @date <= guess_term.finish)
				return guess_term
			end
		}
		return nil
	end
	
	def to_s
		return @right_term.to_s
	end
	
	def week
		return nil if @right_term == nil
		diff = (@date - @right_term.start)
		return ((diff+1)/7).ceil
	end
end