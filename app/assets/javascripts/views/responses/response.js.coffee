define ['jquery', 'underscore', 'backbone', 'models/current_user'], ($, _, Backbone, currentUser) ->
  Response = Backbone.View.extend
    initialize: (options) ->
      @options = options
      @template = _.template $.trim $("#response-item-template").html()

    render: ->
      @setElement @template
        response: @model.toJSON()
        current_user: currentUser.toJSON()
      @

