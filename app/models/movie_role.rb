class MovieRole
  include Mongoid::Document
  field :character, type: String

  embedded_in :movie, touch: true
  belongs_to :actor
end
