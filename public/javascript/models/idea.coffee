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

  comparator: (idea)->
    return idea.get("popularity")
})

window.IdeasView = Backbone.View.extend({
  tagName: 'ul'

  className: 'app'

  # events: {
  #   'click button.new': 'create',
  #   'dblclick input': 'edit',
  #   'click button.undecided#upvote': 'upvote',
  #   'click button#update': 'update',
  # }

  template: ->
    hbs = $('#ideas-template').html()
    template = Handlebars.compile(hbs)
    return template

  initialize: ->
    @model ||= new Ideas
    @model.fetch()
    return this

  # create: ->
  #   name = this.$('li#new input[name=name]').text()
  #   cuisine = this.$('li#new input[name=cuisine]').text()
  #   idea = new Idea
  #   idea.save({name: name, cuisine: cuisine})
  #   @update

  # edit: ->
  #   name = this.$('input[name="name"]').text()
  #   cuisine = this.$('input[name="cuisine"]').text()
  #   this.$('input').attr('readonly', false)
  #   this.$('#update').append('<button>Update</button>')

  # upvote: ->
  #   this.model.upvote
  #   this.$('#upvote button').removeClass()

  # update: ->
  #   this.model.save(
  #     {name: this.$('input[name="name"]').text(),
  #     cuisine: this.$('input[name="cuisine"]').text()})
  #   this.model.fetch()
  #   this.$('#update').remove('button')
  #   this.render()

  render: ->
    json = {ideas: @model.toJSON()}
    $(@el).html(@template(json))
    return this
})
