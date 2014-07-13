define [
  'Backbone.Marionette',
  'hbs!../templates/desktop/views/TodoItem.hbs'
  'Backbone.Localstorage',
], (Marionette, TodoItemTemplate) ->

  TodoItem = Marionette.ItemView.extend
  
    tagName: "li"
    
    template: TodoItemTemplate
    
    ui:
      edit: ".edit"

    events:
      "click      .destroy":  "destroy"
      "dblclick   label":     "onEditClick"
      "keypress   .edit":     "onEditKeypress"
      "blur       .edit":     "onEditBlur"
      "click      .toggle":   "toggle"

    initialize: ->
      @bindTo @model, "change", @render, this

    onRender: ->
      @$el.removeClass "active completed"
      if @model.get("completed")
        @$el.addClass "completed"
      else
        @$el.addClass "active"

    destroy: ->
      @model.destroy()

    toggle: ->
      @model.toggle().save()

    onEditClick: ->
      @$el.addClass "editing"
      @ui.edit.focus()

    updateTodo: ->
      todoText = @ui.edit.val()
      return @destroy() if todoText is ""
      @setTodoText todoText
      @completeEdit()

    onEditBlur: (e) ->
      @updateTodo()

    onEditKeypress: (e) ->
      ENTER_KEY = 13
      @updateTodo() if e.which is ENTER_KEY

    setTodoText: (todoText) ->
      return if todoText.trim() is ""
      @model.set("title", todoText).save()

    completeEdit: ->
      @$el.removeClass "editing"

  exports.TodoItem = TodoItem