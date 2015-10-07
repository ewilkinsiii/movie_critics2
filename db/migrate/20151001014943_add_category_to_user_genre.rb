class AddCategoryToUserGenre < ActiveRecord::Migration
  def change
  	add_column :user_genres, :genre_category, :string
  end
end
