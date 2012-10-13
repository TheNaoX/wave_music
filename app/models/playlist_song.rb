class PlaylistSong < ActiveRecord::Base
  belongs_to :song
  belongs_to :playlist
  attr_accessible :song_id, :playlist_id
end
