define (require) ->
  
  require ['jquery', 'underscore', 'backbone'], ($, _, Backbone) ->

  class ResponseAlternative extends Backbone.View
    
    el: '#scenario-branches'
    
    events: 
      'submit form': 'onFormSubmit',
      'click .btn': 'switchScenario'

    initialize: (options) ->
      @collection.bind "reset", @render, @
      @template = _.template $("#responses-alternative-template").html()
      @templateItem = _.template $("#response-alternative-item-template").html()
      @options = options
      @

    render: ->
      @$el.empty()
      
      @$responses = $ '<div />'
      
      @collection.each _.bind @addRow, this

      $rendered = $ @template()
      
      $rendered.find("#responses-alternative").append @$responses
      
      @$el.append $rendered

      @

    addRow: (response) ->
      @$responses.append @templateItem response.toJSON()

    onFormSubmit: (e) ->
      $el = $(e.target)

      @collection.create
        response: $el.find('textarea').val()
      
      false

    switchScenario: (e) ->
      $el = $(e.currentTarget)
      $(window).trigger 'scenario:change', $el.attr 'href'
      false

    ResponseAlternative
