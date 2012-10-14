class Playlist < ActiveRecord::Base

  attr_accessible :name
  acts_as_api

  belongs_to :user
  has_many :songs, through: :playlist_songs
  has_many :playlist_songs

  scope :search, lambda { |query| where("name ILIKE ?", "%#{query.strip}%" ) }

  api_accessible :as_playlist do |t|
    t.add :id
    t.add :name
    t.add :user_id
    t.add :songs
  end

  def add_songs(song_ids)
    begin
      new_songs = song_ids.map { |s| Song.find s }
      self.songs << new_songs unless new_songs.empty?
    rescue
      false
    end
  end

end
