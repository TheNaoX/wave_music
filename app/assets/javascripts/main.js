var RB = {
  Models: {},
  Collection: {},
  Views: {},

  Initialize: function(){
    Backbone._sync = Backbone.sync;

    Backbone.sync = function(method, model, success, error) {
      if (method == 'create' || method == 'update' || method == 'delete') {
        var auth_options = {};
        auth_options[$("meta[name='csrf-param']").attr('content')] =
          $("meta[name='csrf-token']").attr('content');
        model.set(auth_options, {silent: true});
      }
      return Backbone._sync(method, model, success, error);
    }
    RB.router = new RB.Router();

    Backbone.history.start({pushState: true});
  },

  CSRFSetAutenticityToken: function(){
    jQuery(document).ajaxSend(function(event, xhr, settings) {
      function getCookie(name) {
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
          var cookies = document.cookie.split(';');
          for (var i = 0; i < cookies.length; i++) {
            var cookie = jQuery.trim(cookies[i]);
            // Does this cookie string begin with the name we want?
            if (cookie.substring(0, name.length + 1) == (name + '=')) {
              cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
              break;
            }
          }
        }
        return cookieValue;
      }
      function sameOrigin(url) {
        // url could be relative or scheme relative or absolute
        var host = document.location.host; // host + port
        var protocol = document.location.protocol;
        var sr_origin = '//' + host;
        var origin = protocol + sr_origin;
        // Allow absolute or scheme relative URLs to same origin
        return (url == origin || url.slice(0, origin.length + 1) == origin + '/') ||
          (url == sr_origin || url.slice(0, sr_origin.length + 1) == sr_origin + '/') || // or any other URL that isn't scheme relative or absolute i.e relative.
          !(/^(\/\/|http:|https:).*/.test(url));
      }
      function safeMethod(method) {
        return (/^(GET|POST|HEAD|OPTIONS|TRACE)$/.test(method));
      }
      if (!safeMethod(settings.type) && sameOrigin(settings.url)) {
        xhr.setRequestHeader("X-CSRFToken", getCookie('csrftoken'));
      }
    });
  }
};

$(function(){
  RB.Initialize();
});
