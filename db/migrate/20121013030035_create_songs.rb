class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string   :name
      t.string   :file
      t.timestamps
    end
  end
end
