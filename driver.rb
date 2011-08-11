require './week/DateGrabber'
require 'sinatra'

get '/raw' do
	DateGrabber.new.week.to_s
end

get '/raw/:d' do |date|
	DateGrabber.new(Date.parse(date)).week.to_s
end

get '/' do
	file = File.open("./public/index.html")
	file.read
end

get '/:name' do |n|
	file = File.open("./public/#{n}")
	file.read
end