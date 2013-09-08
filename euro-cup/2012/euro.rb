
euro = Event.find_euro_2012!

euroa = Group.find_by_event_id_and_pos!( euro.id, 1 )
eurob = Group.find_by_event_id_and_pos!( euro.id, 2 )
euroc = Group.find_by_event_id_and_pos!( euro.id, 3 )
eurod = Group.find_by_event_id_and_pos!( euro.id, 4 )

pol = Team.find_by_key!( 'pol' )
gre = Team.find_by_key!( 'gre' )
rus = Team.find_by_key!( 'rus' )
cze = Team.find_by_key!( 'cze' )

ned = Team.find_by_key!( 'ned' )
den = Team.find_by_key!( 'den' )
ger = Team.find_by_key!( 'ger' )
por = Team.find_by_key!( 'por' )

esp = Team.find_by_key!( 'esp' )
ita = Team.find_by_key!( 'ita' )
irl = Team.find_by_key!( 'irl' )
cro = Team.find_by_key!( 'cro' )

ukr = Team.find_by_key!( 'ukr' )
swe = Team.find_by_key!( 'swe' )
fra = Team.find_by_key!( 'fra' )
eng = Team.find_by_key!( 'eng' )



tipico    = Service.find_by_key!( 'tipico'    )
betathome = Service.find_by_key!( 'betathome' )
tipp3     = Service.find_by_key!( 'tipp3'     )


tipico_winner_odds = [   # tipico quotes  27/may
  [ esp, 3.6 ],
  [ ger, 4 ],
  [ ned, 8 ],
  [ fra, 12 ],
  [ eng, 12 ],
  [ ita, 15 ],
  [ por, 20 ],
  [ rus, 25 ],
  [ pol, 45 ],
  [ cro, 50 ],
  [ ukr, 50 ],
  [ swe, 60 ],
  [ gre, 70 ],
  [ cze, 70 ],
  [ den, 100 ],
  [ irl, 100 ]]

EventQuote.create_from_ary!( tipico_winner_odds, tipico, euro )


betathome_winner_odds = [
  [ esp, 3.5 ],
  [ ger, 3.9 ],
  [ ned, 7.5 ],
  [ eng, 10 ],
  [ fra, 15 ],
  [ ita, 15 ],
  [ por, 18 ],
  [ rus, 20 ],
  [ cro, 40 ],
  [ ukr, 40 ],
  [ cze, 50 ],
  [ gre, 50 ],
  [ pol, 50 ],
  [ swe, 65 ],
  [ den, 80 ],
  [ irl, 80 ]] 

EventQuote.create_from_ary!( betathome_winner_odds, betathome, euro )


tipp3_winner_odds = [
  [ esp, 3.5 ],
  [ ger, 3.8 ],
  [ ned, 8 ],
  [ eng, 12 ],
  [ ita, 12 ],
  [ fra, 12 ],
  [ por, 20 ],
  [ rus, 25 ],
  [ cro, 50 ],
  [ ukr, 50 ],
  [ pol, 60 ],
  [ cze, 70 ],
  [ gre, 70 ],
  [ swe, 75 ],
  [ den, 90 ],
  [ irl, 90 ]]

EventQuote.create_from_ary!( tipp3_winner_odds, tipp3, euro )


tipp3_groupa_winner_odds = [
  [ rus, 2.3  ],
  [ pol, 3.4  ],
  [ cze, 4.5  ],
  [ gre, 5    ]]
tipp3_groupb_winner_odds = [
  [ ger, 2.1  ],
  [ ned, 2.6  ],
  [ por, 4.5  ],
  [ den, 15   ]]
tipp3_groupc_winner_odds = [
  [ esp, 1.45 ],
  [ ita, 4    ],
  [ cro, 6.5  ],
  [ irl, 18   ]]
tipp3_groupd_winner_odds = [
  [ eng, 2.6  ],
  [ fra, 2.6  ],
  [ ukr, 5    ],
  [ swe, 6    ]]

GroupQuote.create_from_ary!( tipp3_groupa_winner_odds, tipp3, euroa )
GroupQuote.create_from_ary!( tipp3_groupb_winner_odds, tipp3, eurob )
GroupQuote.create_from_ary!( tipp3_groupc_winner_odds, tipp3, euroc )
GroupQuote.create_from_ary!( tipp3_groupd_winner_odds, tipp3, eurod )

tipico_groupa_winner_odds = [
  [ rus, 2.5  ],
  [ pol, 3.6  ],
  [ cze, 4.7  ],
  [ gre, 5.5  ]]
tipico_groupb_winner_odds = [
  [ ger, 2.05 ],
  [ ned, 2.9  ],
  [ por, 5    ],
  [ den, 20   ]]
tipico_groupc_winner_odds = [
  [ esp, 1.55 ],
  [ ita, 4    ],
  [ cro, 8    ],
  [ irl, 18   ]]
tipico_groupd_winner_odds = [
  [ fra, 2.6  ],
  [ eng, 2.7  ],
  [ ukr, 5.5  ],
  [ swe, 7    ]]

GroupQuote.create_from_ary!( tipico_groupa_winner_odds, tipico, euroa )
GroupQuote.create_from_ary!( tipico_groupb_winner_odds, tipico, eurob )
GroupQuote.create_from_ary!( tipico_groupc_winner_odds, tipico, euroc )
GroupQuote.create_from_ary!( tipico_groupd_winner_odds, tipico, eurod )
