define ['jquery', 'underscore', 'backbone'], ($, _, Backbone) ->
  ResponsesAlternative = Backbone.View.extend
    
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
      
      @collection.each @renderResponse, this

      $rendered = $ @template()
      
      $rendered.find("#responses-alternative").append @$responses
      
      @$el.append $rendered

      @

    renderResponse: (response) ->
      @$responses.append @templateItem response.toJSON()

    onFormSubmit: (e) ->
      $el = $(e.target)

      @collection.create
        response: $el.find('textarea').val()
      ,
        success: _.bind ->
          @collection.fetch()
        , @

      false

    switchScenario: (e) ->
      $el = $(e.currentTarget)
      $(window).trigger 'scenario:change', $el.attr 'href'
      false

