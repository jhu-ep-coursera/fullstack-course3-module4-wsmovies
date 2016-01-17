json.array!(@actors) do |actor|
  json.extract! actor, :id, :first_name, :last_name
  json.url actor_url(actor, format: :v2json)
end
