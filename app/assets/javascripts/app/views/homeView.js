RB.HomeView = Backbone.View.extend({
  el: "#home",

  events: {
    "click #fn-upload-send"          : "uploadAudio",
    "click #fn-create-playlist-send" : "createPlaylist",
    "dblclick .fn-song"              : "addToPlaylist",
    "dblclick .pl-song"              : "stream",
    "keyup #fn-search"               : "search",
    "click .play"                    : "play",
    "click .pause"                   : "pause",
    "click .previous"                : "previous",
    "click .next"                    : "next"
  },

  initialize: function(){
    this.playlist = new Array();
    this.songs = new RB.SongsCollection();
    this.songs.bind("reset", this.render, this);

    this.upload = new RB.UploadController({
      collection: this.songs
    });

    this.songs.fetch();
  },

  previous: function(event){
    var currentSongUrl = $("audio source").attr("src");
    var currentSong = _.find(this.playlist, function(song) { return song.url == currentSongUrl })
    var currentSongIndex = _.indexOf(this.playlist, currentSong)
    if (currentSongIndex <= 0 ) {
      console.log('there is no previous song');
    } else {
      var previousSong = this.playlist[currentSongIndex - 1];
      this.addToStream(previousSong.url, previousSong.album_art_url);
    }
  },

  next: function(event){
    var currentSongUrl = $("audio source").attr("src");
    var currentSong = _.find(this.playlist, function(song) { return song.url == currentSongUrl })
    var currentSongIndex = _.indexOf(this.playlist, currentSong)
    if ((currentSongIndex + 1) == this.playlist.length) {
      console.log('there is no next song');
    } else {
      var previousSong = this.playlist[currentSongIndex + 1];
      this.addToStream(previousSong.url, previousSong.album_art_url);
    }
  },

  pause: function(){
    $('audio')[0].pause();
  },

  play: function(){
    $('audio')[0].play();
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
      artist: this.$("#fn-upload-artist").val() !== "" ? this.$("#fn-upload-artist").val() : null,
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

    this.addToStream(url, album);
  },

  addToStream: function(url, album){
    $('audio source').attr("src", url);
    this.$(".fn-album").attr("src", album);
    $('audio')[0].load();
    $('audio')[0].play();
  },

  addToPlaylist: function(event){
    event.preventDefault();
    var $target = $(event.currentTarget);
    var song = $target.data("song");

    this.playlist.push(song);
    this.playlist = _.uniq(this.playlist);
    $("#pl-songs-list").html("");
    _.each(this.playlist, function(song){
      $('<label />', {
        text: song.filename,
        class: "pl-song"
      }).appendTo("#pl-songs-list").append("</br>").data("song", song);
    });
    if (this.playlist.length == 1) {
      this.addToStream(song.url, song.album_art_url);
    }
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
