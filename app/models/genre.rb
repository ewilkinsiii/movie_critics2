class Genre < ActiveRecord::Base
  has_many :movie_genres
  has_many :movies, through: :movie_genres
  has_many :user_genres
  has_many :users, through: :user_genres
  belongs_to :user
end
