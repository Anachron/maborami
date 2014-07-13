define [
  'Backbone.Marionette',
  'desktop/views/TodoItem',
  'Backbone.Localstorage',
], (Marionette, TodoItemView) ->
  
  TodoList = Marionette.CompositeView.extend(
    
    template: "#template-todoListCompositeView"
    
    itemView: TodoItemView
    
    itemViewContainer: "#todo-list"
    
    ui:
      toggle: "#toggle-all"

    events:
      "click #toggle-all": "onToggleAllClick"

    initialize: ->
      @bindTo @collection, "all", @update, this

    onRender: ->
      @update()

    update: ->
      reduceCompleted = (left, right) ->
        left and right.get("completed")
      allCompleted = @collection.reduce(reduceCompleted, true)
      @ui.toggle.prop "checked", allCompleted
      @$el.parent().toggle !!@collection.length

    onToggleAllClick: (e) ->
      isChecked = e.currentTarget.checked
      @collection.each (todo) ->
        todo.save completed: isChecked
  )

  exports.TodoList = TodoList