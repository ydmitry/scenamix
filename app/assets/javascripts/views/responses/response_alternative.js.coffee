define ['jquery', 'underscore', 'backbone'], ($, _, Backbone) ->
  Response = Backbone.View.extend
    initialize: ->
      @template = _.template $.trim $("#response-alternative-item-template").html()

    render: ->
      @setElement @template @model.toJSON()
      @
