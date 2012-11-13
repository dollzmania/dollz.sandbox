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

    code = File.read( path )
    
    load_worker( code )
  end


private
  def load_worker( code )
    self.class_eval( code )
  end
  
end # class Loader
end # module SportDB::Market
