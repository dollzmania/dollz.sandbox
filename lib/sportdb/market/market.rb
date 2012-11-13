
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
  
  # load built-in (that is, bundled within the gem) named seeds
  # - pass in an array of seed names e.g. [ 'cl/teams', 'cl/2012_13/cl' ] etc.

  def self.load( ary )
    loader = Loader.new
    ary.each do |name|
      loader.load_builtin( name )
    end
  end

  # load built-in (that is, bundled within the gem) named plain text seeds
  # - pass in an array of pairs of event/seed names e.g. [['at.2012/13', 'at/2012_13/bl'], ['cl.2012/13', 'cl/2012_13/cl']] etc.

  def self.read( ary )
    reader = Reader.new
    ary.each do |rec|
      reader.load_builtin( rec[0], rec[1], rec[2] ) # service_key, event_key, name
    end
  end

  class Deleter
    ## todo: move into its own file???    
    
    ## make models available in sportdb module by default with namespace
    #  e.g. lets you use Team instead of Models::Team 
    include SportDB::Models

    def run( args=[] )
      # for now delete all tables

      Service.delete_all
      Quote.delete_all
      GroupQuote.delete_all
      EventQuote.delete_all
    end
    
  end
  
  # delete ALL records (use with care!)
  def self.delete!
    Deleter.new.run
  end # method delete!

  puts "SportDB::Market.banner: >>#{SportDB::Market.banner}<<"
  puts "SportDB::Market.root: >>#{SportDB::Market.root}<<"

end  # module SportDB::Market
