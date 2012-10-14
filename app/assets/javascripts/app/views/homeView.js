RB.HomeView = Backbone.View.extend({
  el: ".theApp",

  events: {
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

    this.songs.fetch();
    this.$('.main-player').on('timeupdate', this.getProgress);
  },

  getProgress: function(event){
    var $target = $(event.currentTarget);
    var track_length = $target[0].duration;
    var secs = $target[0].currentTime;
    var progress = (secs/track_length) * 100;
  },

  previous: function(event){
    var currentSongUrl = $("audio source").attr("src");
    var currentSong = _.find(this.playlist, function(song) { return song.url == currentSongUrl })
    var currentSongIndex = _.indexOf(this.playlist, currentSong)
    if (currentSongIndex <= 0 ) {
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
      $('<tr>', {
        html: '<td>' + song.name + '</td>',
        class: "pl-song"
      }).appendTo("#pl-songs-list").append("</tr>").data("song", song);
    });
    if (this.playlist.length == 1) {
      this.addToStream(song.url, song.album_art_url);
    }
  },

  render: function(){
    $(".library").html("");
    var songs = this.songs.models[0].get("songs");
    _.each(songs, function(song, index){
      songIndex = index + 1;
      $('<tr>', {
        html: '<td>' + songIndex +'</td><td>' + song.name + '</td><td>' + song.duration + '</td><td>' + song.artist + '</td><td>' + song.album + '</td>',
        class: "fn-song"
      }).appendTo(".library").append("</tr>").data("song", song);
    });

  }
});
