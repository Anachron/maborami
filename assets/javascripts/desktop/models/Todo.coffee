define [
  'Backbone',
  'Backbone.Localstorage'
], (Backbone) ->
  
  TodoModel = Backbone.Model.extend(

    localStorage: new Backbone.LocalStorage( "TodoMVC" )

    defaults:
      title: ""
      completed: false
      created: 0

    initialize: ->
      @set "created", Date.now()  if @isNew()
      return

    toggle: ->
      @set "completed", not @isCompleted()

    isCompleted: ->
      @get "completed"
  )

  exports.TodoModel = TodoModel