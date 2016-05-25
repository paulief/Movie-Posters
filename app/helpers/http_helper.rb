require 'http'

module HttpHelper

	HEADERS = {
		"X-Mashape-Key" => "zquo6fAcNNmshkZMlBXDH8KvuR4Ip1mytvojsnGA8wYvSGLN8G",
		"Accept" => "application/json"
	}

	BASE_URL = 'https://community-netflix-roulette.p.mashape.com/api.php?'

	def self.get(params)
		# call get to Mashape API with params as query parameters
		url = "#{BASE_URL}#{format_params(params)}"

		response = HTTP.headers(HEADERS).get(url)

		p response[:code]

		raise 'Bad Request' if response.code != 200

		JSON.parse(response.to_s)
	end

	private

	def self.format_params(params)
		query_parts = params.keys.map do |key|
			no_space = params[key].sub(' ', '+')
			URI.escape("#{key}=#{no_space}")
		end

		query_parts.join('&')
	end

end
