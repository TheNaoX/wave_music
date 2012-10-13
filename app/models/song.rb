class Song < ActiveRecord::Base

  attr_accessible :name, :file
  acts_as_api

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
    self.file.filename
  end

end
