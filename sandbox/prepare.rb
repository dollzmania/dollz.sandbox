###############
#  to run use:
#   $   ruby sandbox/prepare.rb


require_relative 'helper'



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