class RenameUsergenreToUserGenre < ActiveRecord::Migration
  def self.up
    rename_table :usergenres, :user_genres
  end 
  def self.down
    rename_table :user_genres, :usergenres
  end
end
