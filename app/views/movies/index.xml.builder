xml.instruct!
xml.movies do
  @movies.each do |movie|
      xml.movie do
          xml.id movie.id
          xml.title movie.title
          xml.url movie_url(movie, format: :xml)
      end
  end
end
