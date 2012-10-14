RB.HomeView = Backbone.View.extend({
  el: "#home",

  events: {
    "click #fn-upload-send"          : "uploadAudio",
    "click #fn-create-playlist-send" : "createPlaylist",
    "dblclick .fn-song"              : "stream",
    "keyup #fn-search"               : "search"
  },

  initialize: function(){
    this.songs = new RB.SongsCollection();
    this.songs.bind("reset", this.render, this);

    this.upload = new RB.UploadController({
      collection: this.songs
    });

    this.songs.fetch();
  },

  search: function(event){
    var $target = $(event.currentTarget);
    var text = $target.val();

    this.songs.search(text);
  },

  uploadAudio: function(event){
    event.preventDefault();

    var data = {
      file: this.$("#fn-upload-file")[0].files.length > 0 ? $('#fn-upload-file')[0].files[0] : null,
      name: this.$("#fn-upload-name").val() !== "" ? this.$("#fn-upload-name").val() : null
    };

    if(data.file && data.name){
      this.upload.startUpload(data);
    }
  },

  createPlaylist: function(event){
    event.preventDefault();
    var name = this.$("#fn-create-playlist-name").val();

    if(name){
      var newPlaylist = new RB.PlaylistModel({
        name: name
      });

      var request = newPlaylist.save();

      request.done(function(data){
        $("#fn-create-playlist-msg").text(data.message + " id: " + data.playlist);
      });

      request.fail(function(error, type){
        $("#fn-create-playlist-msg").text(type);
      });

    }
  },

  stream: function(event){
    event.preventDefault();
    var $target = $(event.currentTarget);
    var data = $target.data("song");
    var url = data.url;
    var album = data.album_art_url;

    $('audio source').attr("src", url);
    this.$(".fn-album").attr("src", album);
    $('audio')[0].load();
    $('audio')[0].play();

    this.addToPlaylist(data);
  },

  addToPlaylist: function(song){
  },

  render: function(){
    $("#fn-songs-list").html("");
    var songs = this.songs.models[0].get("songs");
    _.each(songs, function(song){
      $('<label />', {
        text: song.filename,
        class: "fn-song"
      }).appendTo("#fn-songs-list").append("</br>").data("song", song);
    });

  }
});
