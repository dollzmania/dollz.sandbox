###############
#  to run use:
#   $   ruby sandbox/prepare.rb


require_relative 'helper'

page = Page.new( read_text("./dl/adidasmaker.html"),
                 base_url: 'http://www.easydoll.com',
                 wayback: '20200217042836',
                 dir: './no1',
                 slug: 'adidas'
               )
# page.dump_images
# page.export
# page.download_images

# page.convert
# page.lint

# page.convert
# page.clean!
# page.cheatsheet




page = Page.new( read_text("./dl/bikinimaker.html"),
                 base_url: 'http://www.easydoll.com',
                 wayback: '20190919233033',
                 dir: './no1',
                 slug: 'bikini'
               )
# page.dump_images
# page.export
# page.download_images

# page.convert
# page.lint

# page.clean!
# page.cheatsheet



page = Page.new( read_text("./dl/prepgothmaker.html"),
                 base_url: 'http://www.easydoll.com',
                 wayback: '20080730202955',
                 dir: './no1',
                 slug: 'goth'
               )
# page.dump_images
# page.export
# page.download_images

# page.convert
# page.lint

# page.clean!
# page.cheatsheet


page = Page.new( read_text("./dl/maleprepmaker.html"),
                 base_url: 'http://www.easydoll.com',
                 wayback: '20190919212407',
                 dir: './no1',
                 slug: 'maleprep'
               )
# page.dump_images
# page.export
# page.download_images

# page.convert
# page.lint

# page.clean!
# page.cheatsheet





page = Page.new( read_text("./dl/prepmaker.html"),
                 base_url: 'http://www.easydoll.com',
                 wayback: '20190919212245',
                 dir: './no1',
                 slug: 'prep'
               )
# page.dump_images
# page.export
# page.download_images

# page.convert
# page.lint

page.clean!
page.cheatsheet



__END__


page = Page.new( read_text( "./dl/mythical.html" ),
                base_url: http://www.dollzmaniadressupgames.com,
                wayback: '20170825102421',
                dir: './no3',
                slug: 'mythical'
                )
# page.dump_images
# page.download_images
# page.export
# page.convert
page.lint

page = Page.new( read_text( "./dl/avatar.html" ),
                   base_url: http://www.dollzmaniadressupgames.com,
                   wayback: '20170825102421',
                   dir: './no3',
                   slug: 'avatar'
                )
# page.dump_images
# page.download_images
# page.export
page.lint

page = Page.new( read_text("./dl/funfashions.html"),
                 base_url: http://www.dollzmaniadressupgames.com,
                 wayback: '20170825102421',
                 dir: './no3',
                 slug: 'funfashions'
               )
# page.dump_images
# page.download_images
# page.export
page.lint
page.cheatsheet


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
page.cheatsheet



puts "bye"