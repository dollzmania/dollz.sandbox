# encoding: utf-8

##########################################
# Champions League 2013/14 Quotes/Odds


cl = Event.find_by_key!( 'cl.2013/14' )


manunited   = Team.find_by_key!( 'manunited' )    # ENG
mancity     = Team.find_by_key!( 'mancity' )
chelsea     = Team.find_by_key!( 'chelsea' )
arsenal     = Team.find_by_key!( 'arsenal' ) 

bayern      = Team.find_by_key!( 'bayern' )    # GER
dortmund    = Team.find_by_key!( 'dortmund' )
leverkusen  = Team.find_by_key!( 'leverkusen' )
schalke     = Team.find_by_key!( 'schalke' )

barcelona   = Team.find_by_key!( 'barcelona' )    # ESP
madrid      = Team.find_by_key!( 'madrid' )
atletico    = Team.find_by_key!( 'atletico' )
realsociedad = Team.find_by_key!( 'realsociedad' )

juventus    = Team.find_by_key!( 'juventus' )    # ITA
napoli      = Team.find_by_key!( 'napoli' )
milan       = Team.find_by_key!( 'milan' )

paris       = Team.find_by_key!( 'paris' )    # FRA
marseille   = Team.find_by_key!( 'marseille' )

benfica     = Team.find_by_key!( 'benfica' )    # POR
porto       = Team.find_by_key!( 'porto' )

moskva      = Team.find_by_key!( 'moskva' )    # RUS
zenit       = Team.find_by_key!( 'zenit' )

donezk      = Team.find_by_key!( 'donezk' )    # UKR
olympiacos  = Team.find_by_key!( 'olympiacos' )    # GRE
anderlecht  = Team.find_by_key!( 'anderlecht' )    # BEL
ajax        = Team.find_by_key!( 'ajax' )    # NEL
galatasaray = Team.find_by_key!( 'galatasaray' )    # TUR
kobenhavn   = Team.find_by_key!( 'kobenhavn' )    # DEN
austria     = Team.find_by_key!( 'austria' )    # AUT
basel       = Team.find_by_key!( 'basel' )    # SUI
celtic      = Team.find_by_key!( 'celtic' )    # SCO
plzen       = Team.find_by_key!( 'plzen' )    # CZE
steaua      = Team.find_by_key!( 'steaua' )    # ROU


betathome_winner_odds = [
 [ bayern, 4.25 ],
 [ barcelona, 5 ],
 [ madrid, 6 ],
 [ chelsea, 9 ],
 [ manunited, 13 ],
 [ mancity, 15 ],
 [ paris, 15 ],
 [ juventus, 16 ],
 [ dortmund, 18 ],
 [ arsenal, 25 ],
 [ milan, 40 ],
 [ atletico, 40 ],
 [ napoli, 40 ],
 [ benfica, 65 ],
 [ porto, 65 ],
 [ zenit, 100 ],
 [ leverkusen, 120 ],
 [ schalke, 125 ],
 [ donezk, 125 ],
 [ realsociedad, 150 ],
 [ marseille, 200 ],
 [ olympiacos, 200 ],
 [ ajax, 300 ],
 [ moskva, 350 ],
 [ galatasaray, 350 ],
 [ celtic, 400 ],
 [ anderlecht, 500 ],
 [ kobenhavn, 500 ],
 [ basel, 500 ],
 [ steaua, 500 ],
 [ austria, 750 ],
 [ plzen, 750 ]]


tipp3     = Service.find_by_key!( 'tipp3' )
betathome = Service.find_by_key!( 'betathome' )

EventQuote.create_from_ary!( betathome_winner_odds, betathome, cl )



## todo: use new version constant for app module e.g. Wettpool::VERSION ??
Prop.create!( key: 'db.cl.2013/14.quotes.version', value: '1' )
