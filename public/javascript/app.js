(function() {
  Backbone.emulateJSON = true;
  window.LunchIdeasApp = Backbone.Router.extend({
    routes: {
      '.*': 'blargh'
    },
    blargh: function() {
      return console.log('This might be something I need to work...');
    }
  });
  $(document).ready(function() {
    window.App = new LunchIdeasApp;
    window.App.ideas = new Ideas;
    return window.App.ideas.fetch({
      success: function(col, res) {
        window.App.ideasView = new IdeasView({
          model: window.App.ideas
        });
        window.App.ideasView.render();
        return Backbone.history.start({
          pushState: true
        });
      }
    });
  });
}).call(this);
