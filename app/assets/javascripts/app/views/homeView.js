RB.HomeView = Backbone.View.extend({
  el: "#home",

  events: {
    "click #fn-upload-send" : "uploadAudio"
  },

  initialize: function(){
    console.log("We are on home view");
    this.upload = new RB.UploadController();
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
  }
});
