Backbone.emulateJSON = true

window.LunchIdeasApp = Backbone.Router.extend({
  routes:{
    '.*': 'blargh'
  }

  blargh: ->
    console.log('This might be something I need to work...')
})

$(document).ready ->
  window.App = new LunchIdeasApp
  window.App.ideas = new Ideas
  window.App.ideas.fetch({
    success: (col, res)->
      window.App.ideasView = new IdeasView({model: window.App.ideas})
      window.App.ideasView.render()
      Backbone.history.start({pushState: true})
  })
