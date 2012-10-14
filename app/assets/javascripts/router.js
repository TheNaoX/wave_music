RB.Router = Backbone.Router.extend({
  routes: {
    "": "Home",
    "sessions/index": "Upload"
  },

  Upload: function(){
    this.uploadView = new RB.UploadView();
  },
  Home: function(){
    this.homeView = new RB.HomeView();
  }

});
