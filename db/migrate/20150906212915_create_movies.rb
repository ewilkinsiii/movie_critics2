class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :director_first_name
      t.string :director_last_name
      t.integer :imdb_id
      t.integer :year
      t.date :release_date
      t.string :mpaa_rating
      t.integer :run_time
      t.string :poster

      t.timestamps null: false
    end
  end
end
