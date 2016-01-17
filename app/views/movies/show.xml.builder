xml.movie do
  xml.id @movie.id
  xml.title @movie.title
  xml.created_at @movie.created_at
  xml.updated_at @movie.updated_at
  xml.roles do
    @movie.roles.each do |role|
      xml.id role.id
      xml.character role.character
      if role.actor_id
        xml << render(partial: "actors/actor", locals: { actor: role.actor })
      end
    end
  end
end
=begin - comment out if need to hide roles
=end
