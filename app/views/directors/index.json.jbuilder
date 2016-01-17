json.array!(@directors) do |director|
  json.extract! director, :id, :id, :first_name, :last_name
  json.url director_url(director, format: :json)
end
