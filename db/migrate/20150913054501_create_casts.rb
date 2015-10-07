class CreateCasts < ActiveRecord::Migration
  def change
    create_table :casts do |t|
      t.string :actor_type
      t.integer :movie_id
      t.string :first_name
      t.string :last_name
      t.string :characters_name
      t.timestamps null: true
    end
  end
end
