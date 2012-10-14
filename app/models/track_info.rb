class TrackInfo < ActiveRecord::Base
  attr_accessible :album_art, :artist, :album, :duration
  has_attached_file :album_art, styles: { large: "259x207>", medium: "209x157>", small: "159x107" }
end
