# encoding: utf-8

Service.create!( key: 'tipp3',     title: 'tipp3' )  # tipp3 classic
Service.create!( key: 'betathome', title: 'bet-at-home' )
Service.create!( key: 'tipico',    title: 'tipico' )

## todo: use new version constant for app module e.g. Wettpool::VERSION ??
Prop.create!( key: 'db.services.version', value: '1' )
