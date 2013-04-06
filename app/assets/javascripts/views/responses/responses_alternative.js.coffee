define ['jquery', 'underscore', 'backbone', 'views/responses/response_alternative'], ($, _, Backbone, ResponseAlternativeView) ->
  ResponsesAlternative = Backbone.View.extend
    
    el: '#scenario-branches'
    
    events: 
      'submit form': 'onFormSubmit'
      'click .response-alternative-switch': 'switchScenario'
      'click .response-alternative-new-button': 'newButton'

    initialize: (options) ->
      @collection.bind "reset", @render, @
      @template = _.template $("#responses-alternative-template").html()
      @options = options
      @

    render: ->
      @$el.empty()
      
      @$responses = $ '<div />'
      
      @collection.each @renderResponse, this

      $rendered = $ @template()
      
      $rendered.find("#responses-alternative").append @$responses
      
      @$el.append $rendered

      @$el.show()
      @

    renderResponse: (response) ->
      responseAlternativeView = new ResponseAlternativeView
        model: response
      @$responses.append responseAlternativeView.render().el

    onFormSubmit: (e) ->
      $el = $(e.target)

      @collection.create
        response:
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

    newButton: (e) ->
      $el = $ e.currentTarget

      templateCreateForm = _.template $('#responses-alternative-create-form-template').html()

      $form = $ templateCreateForm()

      $el.parent().empty().append $form
      false
