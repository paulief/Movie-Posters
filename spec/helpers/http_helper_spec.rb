require_relative '../../app/helpers/http_helper'

RSpec.describe 'HttpHelper' do
	describe '.get' do
		before(:each) do
			allow(HTTP).to receive(:headers).and_return(HTTP)
			allow(HTTP).to receive(:get).and_return({ code: 200, body: { poster: 'poster_url.jpg' } })
		end

		context 'when passed parameters' do
			it 'should call get on HTTP with the correct query string' do
				HttpHelper.get({ title: 'The Shining', year: '1980' })
				expect(HTTP).to have_received(:get).with('https://community-netflix-roulette.p.mashape.com/api.php?title=The+Shining&year=1980')
			end
		end

		context 'when the request fails' do
			before(:each) do
				allow(HTTP).to receive(:get).and_return({ code: 400 })
			end

			it 'should raise an error' do
				expect{ HttpHelper.get({ title: 'Movie', year: '1991' })}.to raise_error('Bad Request')
			end
		end
	end
end
