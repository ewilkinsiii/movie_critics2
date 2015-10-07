class CreateTrailers < ActiveRecord::Migration
  def change
    create_table :trailers do |t|
      t.string :title
      t.string :embed
      t.timestamps null: true
    end
  end
end
