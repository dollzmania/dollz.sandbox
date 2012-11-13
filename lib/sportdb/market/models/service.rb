
## NB: just use namespace SportDB::Models (not SportDB::Models::Market)

module SportDB::Models

class Service < ActiveRecord::Base
    
   has_many :event_quotes, :order => 'odds'   # event_(team_winner)_quotes
   has_many :group_quotes, :order => 'odds'   # group_(team_winner)_quotes
   
end  # class Service

end  # module SportDB::Models
