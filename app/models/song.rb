class Song < ActiveRecord::Base
  
  attr_accessible :name, :file, :album_art, :artist, :album, :duration
  acts_as_api

  has_attached_file :album_art, styles: { large: "259x207>", medium: "209x157>", small: "159x107" }

  mount_uploader :file, FileUploader
  has_many :playlists, through: :playlist_songs
  has_many :playlist_songs

  validates_presence_of :name, :file
  validates_uniqueness_of :name

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
    self.file.file.filename
  end

end
