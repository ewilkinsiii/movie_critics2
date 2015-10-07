class AddGenreCategoryToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :genre_categories, :text
  end
end
