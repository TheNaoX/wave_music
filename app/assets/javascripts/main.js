var RB = {
  Models: {},
  Collection: {},
  Views: {},

  Initialize: function(){
    RB.router = new RB.Router();

    Backbone.history.start({pushState: true});
  }
};

$(function(){
  RB.Initialize();
});
