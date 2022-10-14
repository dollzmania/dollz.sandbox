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
                 puts "!! ERROR:"
                 puts " unknown image format content type: >#{content_type}<"
                 exit 1
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
   path
end



class Page


def initialize( html,
                base_url:,
                dir:,
                slug: )
  @doc = Nokogiri::HTML::DocumentFragment.parse( html )

  @base_url = base_url
  @outdir   = dir
  @slug     = slug
end


def each_image( &blk )
  @doc.search('img').each_with_index do |img, i|
    blk.call( img, i )
  end
end


def export
  recs = []
  each_image do |img,i|
    recs << [norm_path(img['src'])]
  end

  headers = ['src']
  buf = String.new('')
  buf << headers.join(', ')
  buf << "\n"
  recs.each do |rec|
    buf << rec.join( ', ' )
    buf << "\n"
  end

  path = "#{@outdir}/#{@slug}.csv"
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

    img_url = "#{@base_url}/#{img_src}"
    puts "    #{img_url}"

    outpath = "#{@outdir}/#{norm_path( img_src ).downcase}"
    _download_image( img_url, outpath, delay_in_s: 3 )
    ## break if i > 100
  end
end




end  # class Page




DOLLZ_BASE_URL = 'https://web.archive.org/web/20170825102421im_/http://www.dollzmaniadressupgames.com'

=begin
page = Page.new( read_text( "./dl/mythical.html" ),
                base_url: DOLLZ_BASE_URL,
                dir: './no3',
                slug: 'mythical'
                )
page.dump_images
page.download_images
page.export



page = Page.new( read_text( "./dl/avatar.html" ),
                   base_url: DOLLZ_BASE_URL,
                   dir: './no3',
                   slug: 'avatar'
                )
page.dump_images
page.download_images
page.export
=end

page = Page.new( read_text("./dl/funfashions.html"),
                 base_url: DOLLZ_BASE_URL,
                 dir: './no3',
                 slug: 'funfashions'
               )
page.dump_images
page.download_images
page.export


puts "bye"