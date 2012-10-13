RB.SongsCollection = Backbone.Collection.extend({
  url: "/api/songs",
  model: RB.SongModel
});
