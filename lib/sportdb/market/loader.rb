module SportDB::Market

class Loader

## make models available in sportdb module by default with namespace
#  e.g. lets you use Team instead of Models::Team 
  include SportDB::Models


  def initialize( logger=nil )
    if logger.nil?
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
    else
      @logger = logger
    end
  end

  attr_reader :logger
  
  def load_builtin( name ) # load from gem (built-in)
    path = "#{SportDB::Market.root}/db/#{name}.rb"
 
    puts "*** loading data '#{name}' (#{path})..."

    code = File.read_utf8( path )
    
    load_worker( code )
    
    ## for builtin fixtures use VERSION of gem

    Prop.create!( key: "db.#{fixture_name_to_prop_key(name)}.version", value: "sport.market.rb.#{SportDB::Market::VERSION}" )
  end


private

 ##
  # fix/todo: share helper w/ other readers
  
  # helper
  #   change at/2012_13/bl           to at.2012/13.bl
  #    or    quali_2012_13_europe_c  to quali.2012/13.europe.c
  
  def fixture_name_to_prop_key( name )
    prop_key = name.gsub( '/', '.' )
    prop_key = prop_key.gsub( /(\d{4})_(\d{2})/, '\1/\2' )  # 2012_13 => 2012/13
    prop_key = prop_key.gsub( '_', '.' )
    prop_key
  end

  def load_worker( code )
    self.class_eval( code )
  end
  
end # class Loader
end # module SportDB::Market
