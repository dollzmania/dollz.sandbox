
## NB: do NOT require sportdb (avoid circular loading)
#### require 'sportdb'


## todo: how to include 'sportdb/market/version' - does it work? ?

require 'sportdb/market/version'
require 'sportdb/market/schema'
require 'sportdb/market/models/service'
require 'sportdb/market/models/group_quote'
require 'sportdb/market/models/event_quote'
require 'sportdb/market/models/game'
require 'sportdb/market/loader'
require 'sportdb/market/reader'


module SportDB::Market

  def self.banner
    "sportdb-market #{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  ##  cut off folders lib(#1)/sportdb(#2)/market(#3) to get to root
  def self.root
    "#{File.expand_path( File.dirname(File.dirname(File.dirname(File.dirname(__FILE__)))) )}"
  end

  puts "SportDB::Market.banner: >>#{SportDB::Market.banner}<<"
  puts "SportDB::Market.root: >>#{SportDB::Market.root}<<"

end
