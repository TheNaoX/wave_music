class Song < ActiveRecord::Base

  acts_as_api

  mount_uploader :file, FileUploader
  has_many :playlists, through: :playlist_songs
  has_many :playlist_songs

  api_accessible :music do |t|
    t.add :id
    t.add :name
    t.add :filename
    t.add :url
  end
  
  api_accessible :as_playlist do |t|
    t.add :id
    t.add :name
    t.add :filename
    t.add :url
  end

  def url
    self.file.url
  end

  def filename
    self.file.filename
  end

end
