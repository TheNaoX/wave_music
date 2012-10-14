RB.Router = Backbone.Router.extend({
  routes: {
    "": "Home",
    '/sessions/index': "Upload"
  },

  Home: function(){
    this.homeView = new RB.HomeView();
  }

});
