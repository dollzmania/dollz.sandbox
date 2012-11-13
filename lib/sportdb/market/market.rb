
## NB: do NOT require sportdb (avoid circular loading)
#### require 'sportdb'


## todo: how to include 'sportdb/market/version' - does it work? ?

require 'sportdb/market/version'
require 'sportdb/market/schema'
require 'sportdb/market/models/service'
require 'sportdb/market/models/group_quote'
require 'sportdb/market/models/event_quote'
require 'sportdb/market/models/game'
require 'sportdb/market/reader'


module SportDB::Market
  puts "hello from sportdb-market, version #{VERSION}"
end

