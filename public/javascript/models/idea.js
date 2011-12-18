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
    fetchTodays: function() {
      var allIdeas;
      this.fetch();
      allIdeas = this.models;
      return _.select(allIdeas, this.todayOnly);
    },
    todayOnly: function(idea) {
      var day, today;
      console.log(idea);
      day = Date.parse(idea.get('updated_on'));
      today = Date.today();
      return day < today;
    }
  });
  window.IdeaView = Backbone.View.extend({
    tagName: 'li',
    initialize: function() {
      return this.id = this.model.id;
    },
    events: {
      'dblclick input': 'edit',
      'click button.undecided#upvote': 'upvote',
      'click button#update': 'update'
    },
    edit: function() {
      var text;
      text = this.$('.field').text();
      this.$('.field').attr('readonly', false);
      return this.$('#update').append('<button>Update</button>');
    },
    upvote: function() {
      this.model.upvote;
      return this.$('#upvote button').removeClass();
    },
    update: function() {
      this.model.save({
        name: this.$('input[name="name"]').text(),
        cuisine: this.$('input[name="cuisine"]').text()
      });
      this.model.fetch();
      this.$('#update').remove('button');
      return this.render();
    },
    render: function() {
      var hbs, json, template;
      json = this.model.toJSON();
      hbs = $('#idea-template').html();
      template = Handlebars.compile(hbs);
      $(this.el).html(template(json));
      return this;
    }
  });
  window.IdeasView = Backbone.View.extend({
    tagName: 'ul',
    className: 'app',
    events: {
      'click button.new': 'create'
    },
    create: function() {
      var cuisine, idea, name;
      name = this.$('li#new input[name=name]').text();
      cuisine = this.$('li#new input[name=cuisine]').text();
      idea = new Idea;
      idea.save({
        name: name,
        cuisine: cuisine
      });
      return this.update;
    },
    render: function() {
      var hbs, json, template;
      json = this.collection.toJSON();
      hbs = $('#ideas-template').html();
      template = Handlebars.compile(hbs);
      $(this.el).html(template(json));
      return this;
    },
    update: function() {
      this.collection.fetch();
      return this.render();
    }
  });
}).call(this);
