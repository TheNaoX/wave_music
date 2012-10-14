RB.SongsCollection = Backbone.Collection.extend({
  url: "/api/songs",
  model: RB.SongModel,
  search: function(name){
    var old  = this.url;
    var self = this;

    this.url = this.url + "/search";

    this.fetch({data: {name: name}}).done(function(){
      self.url = old;
    });
  }
});
