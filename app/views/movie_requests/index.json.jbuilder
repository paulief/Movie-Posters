json.array!(@movie_requests) do |movie_request|
  json.extract! movie_request, :id, :title, :year, :poster
  json.url movie_request_url(movie_request, format: :json)
end
