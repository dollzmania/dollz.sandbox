
module SportDB::Market

### load quotes from plain text files

class Reader

## make models available in sportdb module by default with namespace
#  e.g. lets you use Team instead of Models::Team 
  include SportDB::Models
  
  
  def initialize
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::INFO
  end

  attr_reader :logger

  def load_with_include_path( service_key, event_key, name, include_path )  # load from file system
    path = "#{include_path}/#{name}.txt"

    puts "*** parsing data '#{name}' (#{path})..."

    reader = LineReader.new( logger, path )
    
    load_worker( service_key, event_key, reader )
    
    Prop.create!( key: "db.#{fixture_name_to_prop_key(name)}.version", value: "file.txt.#{File.mtime(path).strftime('%Y.%m.%d')}" )
  end

  def load_builtin( service_key, event_key, name ) # load from gem (built-in)
    path = "#{SportDB::Market.root}/db/#{name}.txt"

    puts "*** parsing data '#{name}' (#{path})..."

    reader = LineReader.new( logger, path )
    
    load_worker( service_key, event_key, reader )

    Prop.create!( key: "db.#{fixture_name_to_prop_key(name)}.version", value: "sport.market.txt.#{SportDB::Market::VERSION}" )
  end

private


  def load_worker( service_key, event_key, reader )

    ## assume active activerecord connection
    ##
    
    @service = Service.find_by_key!( service_key )
    @event   = Event.find_by_key!( event_key )
    
    puts "Quote Service #{@service.key} >#{@service.title}<"
    puts "Event #{@event.key} >#{@event.title}<"
    
    @known_teams = @event.known_teams_table
    
    parse_quotes( reader )

  end   # method load


  include SportDB::FixtureHelpers


  def find_quotes!( line )
    # extract quotes triplet from line
    # and return it
    # NB: side effect - removes quotes triplet from line string
    
    # e.g. 1,55  3,55  6,44
    
    # NB: (?:)  is used for non-capturing grouping
    
    ## regex1 uses point., e.g. 1.55 for separator
    ## regex2 uses comma-, e.g. 1,55 for separator

    
    regex1 = /[ \t]+(\d{1,3}(?:\.\d{1,3})?)[ \t]+(\d{1,3}(?:\.\d{1,3})?)[ \t]+(\d{1,3}(?:\.\d{1,3})?)/
    regex2 = /[ \t]+(\d{1,3}(?:,\d{1,3})?)[ \t]+(\d{1,3}(?:,\d{1,3})?)[ \t]+(\d{1,3}(?:,\d{1,3})?)/
    
    match = regex1.match( line )
    unless match.nil?
      values = [match[1].to_f, match[2].to_f, match[3].to_f]
      puts "   quotes: >#{values.join('|')}<"
      
      line.sub!( regex1, ' [QUOTES.EN]' )

      return values
    end
    
    match = regex2.match( line )
    unless match.nil?
      values = [match[1].tr(',','.').to_f,
                match[2].tr(',','.').to_f,
                match[3].tr(',','.').to_f]
      puts "   quotes: >#{values.join('|')}<"
      
      line.sub!( regex2, ' [QUOTES.DE]' )

      return values
    end
    
    nil  # return nil; nothing found
  end


  def parse_quotes( reader )
    
    reader.each_line do |line|
  
      if is_round?( line )
        puts "parsing round line: >#{line}<"
        pos = find_round_pos!( line )
        puts "  line: >#{line}<"
        
        @round = Round.find_by_event_id_and_pos!( @event.id, pos )

        
      else
        puts "parsing game (fixture) line: >#{line}<"
        
        match_teams!( line )
        team1_key = find_team1!( line )
        team2_key = find_team2!( line )

        quotes = find_quotes!( line )

        puts "  line: >#{line}<"


        ### todo: cache team lookups in hash?

        team1 = Team.find_by_key!( team1_key )
        team2 = Team.find_by_key!( team2_key )

        ### check if games exists
        ##  with this teams in this round if yes only update
        game = Game.find_by_round_id_and_team1_id_and_team2_id!(
                         @round.id, team1.id, team2.id
        )
        
        quote_attribs = {
          odds1: quotes[0],
          oddsx: quotes[1],
          odds2: quotes[2]
        }
        
        quote = Quote.find_by_service_id_and_game_id( @service.id, game.id )

        if quote.present?
          puts "*** update quote #{quote.id}:"
        else
          puts "*** create quote:"
          quote = Quote.new
          
          more_quote_attribs = {
            service_id:  @service.id,
            game_id:     game.id
          }
          quote_attribs = quote_attribs.merge( more_quote_attribs )
        end

        puts quote_attribs.to_json

        quote.update_attributes!( quote_attribs )
      end
    end # each lines
    
  end # method parse_quotes

end # class Reader

end # module SportDB::Market