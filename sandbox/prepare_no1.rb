###############
#  to run use:
#   $   ruby sandbox/prepare_no1.rb


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
page.cheatsheet





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

# page.clean!
# page.cheatsheet



puts "bye"