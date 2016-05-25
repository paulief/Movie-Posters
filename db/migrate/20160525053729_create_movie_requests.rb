class CreateMovieRequests < ActiveRecord::Migration
  def change
    create_table :movie_requests do |t|
      t.string :title
      t.string :year
      t.string :poster

      t.timestamps null: false
    end
  end
end
