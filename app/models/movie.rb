class Movie
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String

  embeds_many :roles, class_name: "MovieRole"
end
