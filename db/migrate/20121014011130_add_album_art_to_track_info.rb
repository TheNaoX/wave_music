class AddAlbumArtToTrackInfo < ActiveRecord::Migration
  def up
    add_column :songs, :artist, :string
    add_column :songs, :album, :string
    add_column :songs, :duration, :string
    add_attachment :songs, :album_art
  end

  def down
    remove_column :songs, :artist
    remove_column :songs, :album
    remove_column :songs, :duration
    remove_attachment :songs, :album_art
  end
end
