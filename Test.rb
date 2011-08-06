require './DateGrabber'
require 'Date'

fail = false
def t(date, ans)
	grabber =DateGrabber.new(date)
	if(grabber.week != ans)
		fail = true		
		puts "Fail on: " + date.to_s + " Value: " + grabber.week.to_s
	end
end

puts "Kicking off!"

# The base is a saturday of week 9
base = Date.parse("6/8/2011")
t(base -1, 9)
t(base, 9)
t(base +1, 9)
t(base +2, 10)
t(base +3, 10)

# The base is day 1 of the school year
base = Date.parse("5/9/2011")
t(base, 1)
(-15..-1).each{|i|
	t(base +i, nil)
}
t(base +1, 1) #Tuesday
t(base +2, 1) #Wednsday
t(base +3, 1) #Thursday
t(base +4, 1) #Friday
t(base +5, 1) #Saturday
t(base +6, 1) #Sunday
t(base +7, 2) #Monday

puts "All good!" if !fail