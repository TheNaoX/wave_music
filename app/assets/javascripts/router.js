RB.Router = Backbone.Router.extend({
  routes: {
    "": "Home"
  },

  Home: function(){
    console.log("Home");
  }
  
});
