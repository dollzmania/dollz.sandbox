require 'hoe'
require './lib/sportdb/market/version.rb'

Hoe.spec 'sportdb-market' do
  
  self.version = SportDB::Market::VERSION
  
  self.summary = 'sportdb plugin for market quotes (odds, etc)'
  self.description = summary

  self.urls    = ['http://geraldb.github.com/sport.db']
  
  self.author  = 'Gerald Bauer'
  self.email   = 'opensport@googlegroups.com'
    
  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'GEM.README.md'
  self.history_file = 'GEM.HISTORY.md'
  
  self.extra_deps = [
    ['sportdb', '~> 0.5']  # NB: will include activesupport,etc. (NB: soft dep on db adapter)
  ]

end