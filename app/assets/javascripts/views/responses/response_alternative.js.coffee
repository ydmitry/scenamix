define (require) ->
  
  require ['jquery', 'underscore', 'backbone'], ($, _, Backbone) ->

  class ResponseAlternative extends Backbone.View
    
    el: '#scenario-branches'
    
    initialize: ->
      @collection.bind "reset", @render, @     
      @templateItem = _.template $("#response-alternative-item-template").html()
      @

    render: ->
      @$el.empty()
      @collection.each _.bind @addRow, this

      @
        
        
    
    addRow: (response) ->
      @$el.append @templateItem response.toJSON()

    ResponseAlternative
