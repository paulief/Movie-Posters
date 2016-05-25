class MovieRequest < ActiveRecord::Base
	validates_presence_of :title, :year, :poster
end
