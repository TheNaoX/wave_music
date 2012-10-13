class Playlist < ActiveRecord::Base
  acts_as_api

  belongs_to :user
  has_many :songs, through: :playlist_songs
  has_many :playlist_songs

  api_accessible :as_playlist do |t|
    t.add :id
    t.add :name
    t.add :user_id
    t.add :songs
  end

end
