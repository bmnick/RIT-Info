require './DateGrabber'
require 'sinatra'

get '/raw' do
	DateGrabber.new.week.to_s
end

get '/' do
	file = File.open("./public/index.html")
	file.read
end
