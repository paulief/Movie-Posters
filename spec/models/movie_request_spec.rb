require 'rails_helper'

RSpec.describe 'MovieRequest' do
	describe 'validations' do
		context 'when title, year, and poster are present' do
			it 'should be valid' do
				expect(MovieRequest.new(title: 'Title', year: 'Year', poster: 'poster.jpg')).to be_valid
			end
		end

		context 'when title is missing' do
			it 'should be valid' do
				expect(MovieRequest.new(year: 'Year', poster: 'poster.jpg')).to_not be_valid
			end
		end

		context 'when year is missing' do
			it 'should be valid' do
				expect(MovieRequest.new(title: 'Title', poster: 'poster.jpg')).to_not be_valid
			end
		end

		context 'when poster is missing' do
			it 'should be valid' do
				expect(MovieRequest.new(title: 'Title', year: 'Year')).to_not be_valid
			end
		end
	end
end
