class CreateTrackInfos < ActiveRecord::Migration
  def change
    create_table :track_infos do |t|
      t.string  :artist
      t.string  :album
      t.integer :duration

      t.timestamps
    end
  end
end
