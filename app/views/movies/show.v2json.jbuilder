json.extract! @movie, :id, :title, :created_at, :updated_at

json.roles @movie.roles do |role|
  json.id role.id
  json.character role.character
  if role.actor
    json.partial! "actors/actor", locals: {actor: role.actor}
  end
end

=begin - comment out if need to hide roles
=end
