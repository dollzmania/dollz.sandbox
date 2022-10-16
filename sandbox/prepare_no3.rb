###############
#  to run use:
#   $   ruby sandbox/prepare_no3.rb


require_relative 'helper'


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




puts "bye"




