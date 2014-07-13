define [
  'Backbone',
  'desktop/models/Todo',
  'Backbone.Localstorage'
], (Backbone, TodoModel) ->
  
  TodoCollection = Backbone.Collection.extend(
    
    model: TodoModel
    
    localStorage: new Backbone.LocalStorage( "TodoMVC" )
    
    getCompleted: ->
      @filter @_isCompleted

    getActive: ->
      @reject @_isCompleted

    comparator: (todo) ->
      todo.get "created"

    _isCompleted: (todo) ->
      todo.isCompleted()
  )

  exports.TodoCollection = TodoCollection