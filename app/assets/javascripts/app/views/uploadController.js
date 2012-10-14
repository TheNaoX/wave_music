RB.UploadController = Backbone.View.extend({
  initialize: function(){
  },

  startUpload: function(data){
    var xhr      = new XMLHttpRequest();
    var formPost = new FormData();

    formPost.append("file", data.file);
    formPost.append("artist", data.artist);
    formPost.append("name", data.name);

    xhr.upload.addEventListener("progress", $.proxy(this.onProgress, this), false);
    xhr.upload.addEventListener("load", $.proxy(this.onComplete, this), false);

    xhr.open('POST', '/api/uploads');

    xhr.send(formPost);
  },

  onProgress: function(upload){
    var percent = upload.position * 100 / upload.totalSize;
    $("#fn-upload-progress").text(percent+"%");
  },

  onComplete: function(upload){
    $("#fn-upload-progress").text("100% Complete");
    this.collection.fetch();
  }

});
