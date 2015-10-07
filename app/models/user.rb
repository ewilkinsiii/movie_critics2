class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_messageable
  has_many :user_genres
  has_many :genres, through: :user_genres
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :movies
  has_many :reviews, dependent: :destroy
  accepts_nested_attributes_for :genres, :reject_if => :all_blank, :allow_destroy => true

  def category_list
    list = ["Action", "Adventure", "Animation", "Biography" , "Comedy", "Crime", "Family", "Fiction", "Fantasy", "Historical", "Horror", "Mystery", "Paranoid", "Philosophial", "Political", "Romance", "Saga", "Satire", "Science Fiction", "Slice of Life", "Speculative", "Thriller", "Urban", "Musical", "Drama", "Sport"]
    return list
  end
end

