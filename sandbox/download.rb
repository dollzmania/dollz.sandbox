require  'cocos'
require  'fetcher'
require  'nokogiri'



def _download_image( image_url, outpath,
                    cache: true,
                    delay_in_s: 3 )

   if cache && File.exist?( outpath )
      puts "   found in cache >#{outpath}<; skipping..."
      return
   end

    res = Fetcher.get( image_url )

   if res.code == '200'
      content_type   = res.content_type
      content_length = res.content_length

      puts "  content_type: #{content_type}, content_length: #{content_length}"

      format = if content_type =~ %r{image/jpeg}i
                 'jpg'
               elsif content_type =~ %r{image/png}i
                 'png'
               elsif content_type =~ %r{image/gif}i
                 'gif'
               else
                 puts "!! WARN:"
                 puts " unknown image format content type: >#{content_type}<"
                 '???'
               end

      blob = res.body.to_s

      ## save image - using b(inary) mode
      puts "  saving to <#{outpath}>..."
      write_blob( outpath, blob )
   else
      puts "!! ERROR - failed to download image; sorry - #{res.code} #{res.message}"
      exit 1
   end

    puts "  sleeping #{delay_in_s} sec(s)..."
    sleep( delay_in_s )
end


def norm_path( path )
   ## change %20  to underscore
   ## e.g. fashion/coat_fash001%20(1).png
   ##      fashion/coat_fash001_(1).png
   path = path.gsub( '%20', '_' )

   ##  change // to /
   ##  e.g. headsandbodyparts//crossedlegs.gif
   ##       headsandbodyparts/crossedlegs.gif
   path = path.gsub( '//', '/' )
   path
end



class Page


def initialize( html,
                base_url:,
                dir:,
                slug:,
                renames: nil )
  @doc = Nokogiri::HTML::DocumentFragment.parse( html )

  @base_url = base_url
  @outdir   = dir
  @slug     = slug
  @renames  = renames
end


def each_image( &blk )
  @doc.search('img').each_with_index do |img, i|
    blk.call( img, i )
  end
end


def clean!
   ## delete / remove all .gif,.bmp,.art, images
   files = Dir.glob( "#{@outdir}/**/*.{gif,bmp,art}" )
   puts "   #{files.size} image(s) found in >#{@outdir}<"
   pp files

   files.each do |file|
      FileUtils.rm( file )
   end
end


def convert
   ## check if all images are present
   ##   AND converted to .png (standard/default) format
   each_image do |img,i|
    img_src = img['src']

    ## auto-remove base url (make relative)
    img_src = img_src.sub( "#{@base_url}/", '' )

    ## normalize for outpath lookup
    path = _local_img_src( img_src )

    extname  = File.extname( path )
    ## note: org is in png (no need to convert)
    ##  or check if already converted
    next  if extname == '.png'

    basename = File.basename( path, extname )
    dirname  = File.dirname( path )

    ## first check if present png conversion
    png_path = "#{dirname}/#{basename}.png"
    next  if File.exist?( "#{@outdir}/#{png_path}" )

    ## needs conversion
    ## check if present
    if extname == '.art'
       ## (auto-)change to .bmp
       extname = '.bmp'
       path    = "#{dirname}/#{basename}.bmp"
    end

    if !File.exist?( "#{@outdir}/#{path}" )
         puts "!! WARN - org image >#{extname}< missing in >#{@slug}<:"
         puts "     #{path}  /  #{img_src}"
    else
         puts "==>  convert from #{extname} to .png - #{path}..."


         cmd = "magick convert #{@outdir}/#{path} #{@outdir}/#{png_path}"
         puts "   #{cmd}"
         ## todo/fix:   check return value!!! magick comand not available (in path) and so on!!!
         system( cmd )

         ## note: check for multi-images for gif
         ##   save  image-0.png  to  image.png
         path0 = "#{dirname}/#{basename}-0.png"
         if extname == '.gif' && File.exist?( "#{@outdir}/#{path0}" )
           puts "   saving #{path0} to #{png_path}..."

           blob = File.open( "#{@outdir}/#{path0}", 'rb' ) { |f| f.read }
           File.open( "#{@outdir}/#{path}", 'wb' ) { |f| f.write( blob ) }
         end
    end
  end
end


def _local_img_src( img_src )
    ## normalize for outpath lookup
    path = norm_path( img_src ).downcase
    path = @renames[ path ]   if @renames && @renames.has_key?( path )
    path
end


def lint
   images = {}   ## check for duplicates (w/o extensions)

   ## check if all images are present
   ##   AND converted to .png (standard/default) format
   each_image do |img,i|
    img_src = img['src']

    ## auto-remove base url (make relative)
    img_src = img_src.sub( "#{@base_url}/", '' )

    ## normalize for outpath lookup
    path = _local_img_src( img_src )


    extname  = File.extname( path )
    basename = File.basename( path, extname )
    dirname  = File.dirname( path )

    ## check for duplicates (w/o extensions)
    key = "#{dirname}/#{basename}"
    if images[ key ]
       puts "!! ERROR - duplicate name for >#{path}< exit:"
       pp   images[ key ]
       exit 1
    else
       images[ key ] ||= []
       images[ key ] << path
    end


    if extname == '.png'
      ## check if present
      if !File.exist?( "#{@outdir}/#{path}" )
         puts "!! WARN [download] - .png image missing in >#{@slug}<:"
         puts "     #{path}  /  #{img_src}"
      end
    else
      ## first check if present png conversion
      png_path = "#{dirname}/#{basename}.png"
      if !File.exist?( "#{@outdir}/#{png_path}" )
        ## check if source extists in the first place (or only conversion missing)
        if !File.exist?( "#{@outdir}/#{path}" )
          puts "!! WARN [download] - #{extname} image missing in >#{@slug}<:"
          puts "     #{path}  /  #{img_src}"
        else
          puts "!! WARN [convert] - .png (converted from >#{extname}<) image missing in >#{@slug}<:"
          puts "     #{path}  /  #{img_src}"
        end
     end
    end
  end
end

def export
  recs = []
  each_image do |img,i|

    img_src = img['src']

    ## auto-remove base url (make relative)
    img_src = img_src.sub( "#{@base_url}/", '' )
    recs << [img_src]
  end

  headers = ['src']
  buf = String.new('')
  buf << headers.join(', ')
  buf << "\n"
  recs.each do |rec|
    buf << rec.join( ', ' )
    buf << "\n"
  end

  path = "./tmp/#{@slug}.images.csv"
  write_text( path, buf )
end


def dump_images
   each_image do |img,i|
     print "[#{i+1}]  "
     img_src = img['src']
     if img_src != norm_path( img_src )
       print " !! #{img_src} => "
     end
     print norm_path(img_src)
     print "\n"
   end
end


def download_images
   each_image do |img, i|
    puts "==> #{i+1}"
    img_src = img['src']
    puts "   #{img_src}"

    ## auto-remove base url (make relative)
    img_src = img_src.sub( "#{@base_url}/", '' )
    if img_src.start_with?( 'http' )
      puts "!! image src NOT relative; sorry"
      exit 1
    end

    outpath = "#{@outdir}/#{norm_path( img_src ).downcase}"

    img_url = "#{@base_url}/#{img_src}"
    puts "    #{img_url}"

    _download_image( img_url, outpath, delay_in_s: 3 )
    ## break if i > 100
  end
end




end  # class Page




DOLLZ_BASE_URL = 'https://web.archive.org/web/20170825102421im_/http://www.dollzmaniadressupgames.com'


page = Page.new( read_text( "./dl/mythical.html" ),
                base_url: DOLLZ_BASE_URL,
                dir: './no3',
                slug: 'mythical'
                )
# page.dump_images
# page.download_images
# page.export
# page.convert
page.lint

page = Page.new( read_text( "./dl/avatar.html" ),
                   base_url: DOLLZ_BASE_URL,
                   dir: './no3',
                   slug: 'avatar'
                )
# page.dump_images
# page.download_images
# page.export
page.lint

page = Page.new( read_text("./dl/funfashions.html"),
                 base_url: DOLLZ_BASE_URL,
                 dir: './no3',
                 slug: 'funfashions'
               )
# page.dump_images
# page.download_images
# page.export
page.lint


## note:
##    (auto-)rename for duplicates with diffenent extsions e.g.
##   dresses/reddress.gif  & dresses/reddress.art
##   shirts/blacktop6.gif  & shirts/blacktop6.art
##   headsandbodyparts/gothhead42.gif & headsandbodyparts/gothhead42.art
##    conflict if all converted to .png!!!

page = Page.new( read_text("./dl/gothmaker.html"),
                 base_url: 'https://www.angelfire.com/falcon/majinamara/dollz',
                 dir: './no2',
                 slug: 'goth',
                 renames: {
                   'dresses/reddress.art' => 'dresses/reddress2.art',
                   'shirts/blacktop6.art' => 'shirts/blacktop6a.art',
                   'headsandbodyparts/gothhead42.art' => 'headsandbodyparts/gothhead42a.art',
                 }
               )
# page.dump_images
# page.download_images
# page.export

# page.convert
page.lint
# page.clean!


puts "bye"