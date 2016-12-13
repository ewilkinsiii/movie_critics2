class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_messageable
  has_many :user_genres
  has_many :genres, through: :user_genres
  has_attached_file :avatar, :styles => { :small => "100x100#", thumb: "100x100>", :large => "500x500>" }, :processors => [:cropper]
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_avatar, :if => :cropping?
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :movies
  has_many :reviews, dependent: :destroy
  accepts_nested_attributes_for :genres, :reject_if => :all_blank, :allow_destroy => true

  def category_list
    list = ["Action", "Adventure", "Animation", "Biography" , "Comedy", "Crime", "Family", "Fiction", "Fantasy", "Historical", "Horror", "Mystery", "Paranoid", "Philosophial", "Political", "Romance", "Saga", "Satire", "Science Fiction", "Slice of Life", "Speculative", "Thriller", "Urban", "Musical", "Drama", "Sport"]
    return list
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end
  
  private
  
  def reprocess_avatar
    avatar.reprocess!
  end
end

