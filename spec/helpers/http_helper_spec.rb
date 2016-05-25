require 'rails_helper'

class MockResponse
	def initialize(code, body)
		@code = code
		@body = body
	end

	def code
		@code
	end

	def body
		@body
	end

	def to_s
		{ code: @code, body: @body }.to_json
	end
end

RSpec.describe 'HttpHelper' do
	describe '.get' do
		before(:each) do
			allow(HTTP).to receive(:headers).and_return(HTTP)
			allow(HTTP).to receive(:get).and_return(MockResponse.new(200, { poster: 'poster.jpg' }))
		end

		context 'when passed simple parameters' do
			it 'should call get on HTTP with the correct query string' do
				HttpHelper.get({ title: 'Interstellar', year: '2015' })
				expect(HTTP).to have_received(:get).with('https://community-netflix-roulette.p.mashape.com/api.php?title=Interstellar&year=2015')
			end
		end

		context 'when there is a space in the movie title' do
			it 'should call get on HTTP with the space correctly replaced with +' do
				HttpHelper.get({ title: 'The Shining', year: '1980' })
				expect(HTTP).to have_received(:get).with('https://community-netflix-roulette.p.mashape.com/api.php?title=The+Shining&year=1980')
			end
		end

		context 'when there is an escapable character other than space in the movie title' do
			it 'should call get on HTTP with the character escaped' do
				HttpHelper.get({ title: 'The " Movie', year: '2006' })
				expect(HTTP).to have_received(:get).with('https://community-netflix-roulette.p.mashape.com/api.php?title=The+%22+Movie&year=2006')
			end
		end
	end
end
