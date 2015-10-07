class CreateUsergenres < ActiveRecord::Migration
  def change
    create_table :usergenres do |t|
      t.integer :user_id
      t.integer :genre_id
      t.timestamps null: true
    end
  end
end
