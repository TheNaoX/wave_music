RB.Router = Backbone.Router.extend({
  routes: {
    "": "Home"
  },

  Home: function(){
    this.homeView = new RB.HomeView();
  }
  
});
