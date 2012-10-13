class Song < ActiveRecord::Base
  has_many :playlists, through: :playlist_songs
  has_many :playlist_songs
end
