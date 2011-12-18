window.Idea = Backbone.Model.extend({

  defaults: {
    popularity: 0
  }

  upvote: ->
    if this.set({'popularity': this.get('popularity') + 1})
      this.save
    return this.get('popularity')

  urlRoot: '/ideas'

  name: (newName) ->
    if newName
      this.set({name: newName})
      newName
    this.save
    this.get('name')

  cuisine: (newCuisine) ->
    if newCuisine
      this.set({cuisine: newCuisine})
      newCuisine
    this.save
    this.get('cuisine')
})

window.Ideas = Backbone.Collection.extend({
  model: window.Idea
  url: '/ideas'

  fetchTodays: ->
    this.fetch()
    allIdeas = this.models
    return _.select(allIdeas, this.todayOnly)

  todayOnly: (idea) ->
    console.log idea
    day = Date.parse(idea.get('updated_on'))
    today = Date.today()
    day < today
})

window.IdeaView = Backbone.View.extend({
  tagName: 'li'

  initialize: ->
    this.id = this.model.id

  events: {
    'dblclick input': 'edit',
    'click button.undecided#upvote': 'upvote',
    'click button#update': 'update'
  }

  edit: ->
    text = this.$('.field').text()
    this.$('.field').attr('readonly', false)
    this.$('#update').append('<button>Update</button>')

  upvote: ->
    this.model.upvote
    this.$('#upvote button').removeClass()

  update: ->
    this.model.save(
      {name: this.$('input[name="name"]').text(),
      cuisine: this.$('input[name="cuisine"]').text()})
    this.model.fetch()
    this.$('#update').remove('button')
    this.render()

  render: ->
    json = this.model.toJSON()
    hbs = $('#idea-template').html()
    template = Handlebars.compile(hbs)
    $(this.el).html(template(json))
    return this

})

window.IdeasView = Backbone.View.extend({
  tagName: 'ul'

  className: 'app'

  events: {
    'click button.new': 'create'
  }

  create: ->
    name = this.$('li#new input[name=name]').text()
    cuisine = this.$('li#new input[name=cuisine]').text()
    idea = new Idea
    idea.save({name: name, cuisine: cuisine})
    this.update


  render: ->
    json = this.collection.toJSON()
    hbs = $('#ideas-template').html()
    template = Handlebars.compile(hbs)
    $(this.el).html(template(json))
    return this

  update: ->
    this.collection.fetch()
    this.render()

})
