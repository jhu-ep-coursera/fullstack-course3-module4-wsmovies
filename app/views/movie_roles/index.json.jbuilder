json.array!(@movie_roles) do |movie_role|
  json.extract! movie_role, :id, :character, :actor_id
  json.url movie_role_url(@movie, movie_role, format: :json)
end
