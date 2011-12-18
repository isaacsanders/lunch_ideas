Backbone.emulateJSON = true

window.LunchIdeasApp = Backbone.Router.extend({
  routes: {
    '/': '_index'
  }

  _index: ->
    this.ideasView.render()
})

$(document).ready ->
  window.App = new LunchIdeasApp
  window.App.ideas = new Ideas
  window.App.ideasView = new IdeasView({collection: window.App.ideas})
  Backbone.history.start({pushState: true, root: '/index.html'})
  window.App.navigate('/', true)
