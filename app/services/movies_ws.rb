class MoviesWS
  include HTTParty
  debug_output $stdout
  base_uri "http://localhost:3000"
#  headers "Content-Type"=>"application/json"
end
