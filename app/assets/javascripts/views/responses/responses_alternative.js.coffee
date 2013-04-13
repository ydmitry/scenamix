define ['jquery', 'underscore', 'backbone', 'views/responses/response_alternative'], ($, _, Backbone, ResponseAlternativeView) ->
  ResponsesAlternative = Backbone.View.extend
    
    el: '#scenario-branches'
    
    events: 
      'submit form': 'onFormSubmit'
      'click .response-alternative-switch': 'switchScenario'
      'click .response-alternative-new-button': 'newButton'

    initialize: (options) ->
      @model.bind "change", @render, @
      @template = _.template $.trim $("#responses-alternative-template").html()
      @options = options
      @

    render: ->
      @$el.empty()

      @$responses = $ '<div />'

      @model.responses.each @renderResponse, this

      $rendered = $ @template
        response: @model.toJSON()

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

      @model.responses.create
        response:
          response: $el.find('textarea').val()
      ,
        success: _.bind ->
          @model.responses.fetch()
        , @

      false

    switchScenario: (e) ->
      $el = $(e.currentTarget)
      $(window).trigger 'scenario:change', $el.attr 'href'
      false

    newButton: (e) ->
      $el = $ e.currentTarget

      templateCreateForm = _.template $.trim $('#responses-alternative-create-form-template').html()

      $form = $ templateCreateForm()

      $el.parent().empty().append $form

      $form.find('textarea').focus()

      false
