class AddAlbumArtToTrackInfo < ActiveRecord::Migration
  def up
    add_attachment :track_infos, :album_art
  end

  def down
    remove_attachment :track_infos, :album_art
  end
end
