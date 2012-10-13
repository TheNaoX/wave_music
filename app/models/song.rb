class Song < ActiveRecord::Base
  mount_uploader :file, FileUploader
  has_many :playlists, through: :playlist_songs
  has_many :playlist_songs
end
