class Movie < ActiveRecord::Base
	searchkick
	belongs_to :user
	has_many :reviews
	has_many :trailers
	has_many :movie_genres
    has_many :genres, through: :movie_genres
    has_many :casts
	has_attached_file :image, styles: {medium: "400x600#", thumbnail: "60x60#"}
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end