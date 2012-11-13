
## NB: just use namespace SportDB::Models (not SportDB::Models::Market)

module SportDB::Models

################################
## extend Game w/ quotes etc.

class Game
  
  has_many   :quotes
   
end  # class Game

end  # module SportDB::Models
