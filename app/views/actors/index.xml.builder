xml.actors do
  @actors.each do |actor|
    xml.actor do 
      xml.id actor.id
      xml.name actor.name
      xml.url actor_url(actor, format: :xml)
    end
  end
end
