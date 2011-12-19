(function() {
  window.Idea = Backbone.Model.extend({
    defaults: {
      popularity: 0
    },
    upvote: function() {
      if (this.set({
        'popularity': this.get('popularity') + 1
      })) {
        this.save;
      }
      return this.get('popularity');
    },
    urlRoot: '/ideas',
    name: function(newName) {
      if (newName) {
        this.set({
          name: newName
        });
        newName;
      }
      this.save;
      return this.get('name');
    },
    cuisine: function(newCuisine) {
      if (newCuisine) {
        this.set({
          cuisine: newCuisine
        });
        newCuisine;
      }
      this.save;
      return this.get('cuisine');
    }
  });
  window.Ideas = Backbone.Collection.extend({
    model: window.Idea,
    url: '/ideas',
    comparator: function(idea) {
      return idea.get("popularity");
    }
  });
  window.IdeasView = Backbone.View.extend({
    tagName: 'ul',
    className: 'app',
    template: function() {
      var hbs, template;
      hbs = $('#ideas-template').html();
      template = Handlebars.compile(hbs);
      return template;
    },
    initialize: function() {
      this.model || (this.model = new Ideas);
      this.model.fetch();
      return this;
    },
    render: function() {
      var json;
      json = {
        ideas: this.model.toJSON()
      };
      $(this.el).html(this.template(json));
      return this;
    }
  });
}).call(this);
