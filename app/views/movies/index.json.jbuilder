json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :description, :director_first_name, :director_last_name, :imdb_id, :year, :release_date, :mpaa_rating, :run_time, :poster
  json.url movie_url(movie, format: :json)
end
