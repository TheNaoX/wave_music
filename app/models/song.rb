class Song < ActiveRecord::Base
  
  attr_accessible :name, :file, :album_art, :artist, :album, :duration
  acts_as_api

  has_attached_file :album_art, styles: { large: "259x207>", medium: "209x157>", small: "159x107" }

  mount_uploader :file, FileUploader
  has_many :playlists, through: :playlist_songs
  has_many :playlist_songs

  validates_presence_of :name, :artist, :file
  validates_uniqueness_of :name

  before_create :get_track_info

  api_accessible :music do |t|
    t.add :id
    t.add :name
    t.add :artist
    t.add :album
    t.add :album_art_url
    t.add :filename
    t.add :url
  end
  
  api_accessible :as_playlist do |t|
    t.add :id
    t.add :name
    t.add :artist
    t.add :album
    t.add :album_art_url
    t.add :filename
    t.add :url
  end

  def album_art_url
    self.album_art(:large)
  end

  def url
    self.file.url
  end

  def filename
    self.file.file.filename
  end

  private

  def get_track_info
    lastfm = Lastfm.new(LASTFM_API['api_key'], LASTFM_API['api_secret'])
    track_info = lastfm.track.get_info(artist: self.artist, track: self.name)
    self.album = track_info['album']['title']
    file = URI.parse(track_info['album']['image'].last['content'])
    self.album_art = file
    self.duration = track_info['duration']
  end

end
