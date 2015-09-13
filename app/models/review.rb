class Review < ActiveRecord::Base
	acts_as_votable
	belongs_to :user
	belongs_to :movie
end
