define ['jquery', 'underscore', 'backbone', 'views/responses/responses_alternative', 'collections/responses', 'views/responses/response'], ($, _, Backbone, ResponsesAlternativeView, ResponseCollection, ReponseView) ->
  ScenesShow = Backbone.View.extend

    el: '#layout-content-container'

    events:

      'submit .response-delete': 'onResponseDelete'
      'submit #response-post-form': 'onResponsePost'
      'click .response-alternative': 'onResponseAlternative'
      'click .response-weight': 'onResponseWeight'
      'click .scenario-sequel': 'onScenarioSequel'
      'mouseover #scenario-current-responses .response': 'onResponseMouseover'

    initialize: (options) ->
      $(window).on 'scenario:change', _.bind @onScenarioChange, @
      @template = _.template $("#responses-template").html()
      @options = options
      @

    render: ->

      @

    renderResponse: (response) ->
      responseView = new ReponseView
        model: response
      @$responses.append responseView.render().el

    onResponseDelete: (e) -> confirm($(e.target).find('.btn').data('confirm'))

    onResponseMouseover: (e) -> 
      $response = $ e.currentTarget
      $el = $response.find '.response-alternative'
      @responseAlternative $el if $el.length > 0

    onResponseAlternative: (e) ->
      $el = $ e.currentTarget

      @responseAlternative $el

      false

    responseAlternative: ($el) ->
      $response = $el.parents '.response'

      @$el.find('#scenario-current-responses').find('.response').removeClass 'alert-info'      

      $response.addClass 'alert-info'

      @responseAlternativeCollection = null

      if !@responseAlternativeView
        @responseAlternativeView = null
      else 
        @responseAlternativeView.undelegateEvents()

      @responseAlternativeCollection = new ResponseCollection
        url: $el.attr 'href'

      @responseAlternativeView = new ResponsesAlternativeView
        collection: @responseAlternativeCollection
      
      @responseAlternativeCollection.fetch()

    onResponseWeight: (e) ->
      $el = $ e.currentTarget
      url = $el.attr('href')
      $.ajax url,
        type: 'put'
        success: (data) ->          
          $el.siblings('.response-weight-value').html data.votes

      false

    onScenarioChange: (e, url) ->

      responseCollection = new ResponseCollection
        url: url 
      
      responseCollection.fetch
        success: _.bind @onScenarioChangeLoad, @

      $(window).trigger 'scenario:changed', url

      false

    onScenarioChangeLoad: (responseCollection) ->
      @$responsesWrap = @$ '#scenario-responses-wrap'

      @$responsesWrap.empty()

      @$responses = $ '<div />'

      responseCollection.each @renderResponse, this

      responseLast = responseCollection.last()

      $rendered = $ @template
        response_id: responseLast.get('id')
        scene_id: responseLast.get('scene_id')

      $rendered.find("#scenario-current-responses").append @$responses

      @$responsesWrap.append $rendered

      @responseAlternativeCollection = null

      if !!@responseAlternativeView
        @responseAlternativeView.$el.empty()

      false

    onScenarioSequel: (e) ->
      $el = $ e.currentTarget

      templateCreateForm = _.template $('#responses-create-form-template').html()

      $form = $ templateCreateForm
        parent_id: $el.data 'parent_id'
        scene_id: $el.data 'scene_id'

      $el.parent().empty().append $form

      $form.on 'submit', _.bind @onResponsePost, @

      false
    ,

    onResponsePost: (e) ->
      $form = $ e.target
      url = $form.attr 'action'

      responseCollection = new ResponseCollection
        url: url

      responseCollection.create
        response: $form.find('textarea').val()
        parent_id: $form.find('[name="parent_id"]').val()
      ,
        success: _.bind (response) ->
          responseCollection = new ResponseCollection
            url: '/scenes/' + response.get('scene_id') + '/responses/' + response.get('id')
          responseCollection.fetch
            success: _.bind @onScenarioChangeLoad, @
        , @


      false

