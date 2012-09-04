class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.text :area
      t.string :latitude
      t.string :longitude
      t.datetime :seen

      t.timestamps
    end
  end
end
