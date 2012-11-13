
module SportDB::Market


class CreateDB

## make models available in sportdb module by default with namespace
#  e.g. lets you use Team instead of Models::Team 
  include SportDB::Models


  def self.up
  
    ActiveRecord::Schema.define do

create_table :services do |t|  # quote service (e.g. tipp3,tipico,etc.)
  t.string     :title,  :null => false
  t.string     :key,    :null => false
  t.timestamps
end

create_table :quotes do |t|
  t.references :service, :null => false   # quote service (e.g. tipp3,tipico,etc.)
  t.references :game,    :null => false
  t.decimal    :odds1,   :null => false
  t.decimal    :oddsx,   :null => false
  t.decimal    :odds2,   :null => false
  t.string     :comments
  t.timestamps
end

create_table :event_quotes do |t|
  t.references  :service, :null => false   # quote service (e.g. tipp3,tipico,etc.)
  t.references  :event,   :null => false
  t.references  :team,    :null => false
  t.decimal     :odds,    :null => false   # winner odds (e.g. 3,5 or 90 etc.)
  t.string      :comments
  t.timestamps
end

create_table :group_quotes do |t|
  t.references  :service, :null => false   # quote service (e.g. tipp3,tipico,etc.)
  t.references  :group,   :null => false
  t.references  :team,    :null => false
  t.decimal     :odds,    :null => false   # winner odds (e.g. 3,5 or 90 etc.)
  t.string      :comments
  t.timestamps
end

    end # block Schema.define

    Prop.create!( key: 'db.schema.sport.market.version', value: SportDB::Market::VERSION )

  end # method self.up

end # class CreateDB


end # module SportDB::Market
