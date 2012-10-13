class Song < ActiveRecord::Base

  acts_as_api

  mount_uploader :file, FileUploader
  has_many :playlists, through: :playlist_songs
  has_many :playlist_songs

  api_accessible :music do |t|
    t.add :name
    t.add :file
  end
end
