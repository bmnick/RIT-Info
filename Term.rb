require 'Date'
require 'net/https'
require 'uri'

class Term

	attr_reader :start
	attr_reader :finish
	
	@@terms = Hash.new
	
	def Term.get_term(term)
		term = term.to_s
		@@terms[term] ||= Term.new(term)
		@@terms[term]
	end
	
	def initialize(term = 20111)
		@term = term
		
		raw = get_raw_for_term
		start_str = raw[/\d{2}\/\d{2}\/\d{4}/]
		raw = raw.sub(start_str,'')
		finish_str = raw[/\d{2}\/\d{2}\/\d{4}/]
		
		@start = parse(start_str)
		@finish = parse(finish_str)
	end
	
	def parse(str)
		parts = str.split("/")
		month = parts[0]
		day = parts[1]
		year = parts[2]
		
		return Date.parse(day + '-' + month + '-' + year)
	end
	
	def get_raw_for_term ()
		uri =  URI.parse("https://registration.rit.edu/alpha/apars/dialog/termInfo/getTermDetails?term=" + @term.to_s)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	
		request = Net::HTTP::Get.new(uri.request_uri)

		response = http.request(request)
		response.body[/Starts.*Ends.*Important/]
	end
	
	def to_s
		return @start.to_s + ', ' + @finish.to_s
	end
end