define ['jquery', 'underscore', 'backbone', 'views/responses/responses_alternative', 'collections/responses', 'views/responses/response'], ($, _, Backbone, ResponsesAlternativeView, ResponseCollection, ReponseView) ->
  ScenesShow = Backbone.View.extend

    el: '#layout-content-container'

    events:

      'submit .response-delete': 'onResponseDelete'
      'submit .response-post-form': 'onResponsePost'
      'click .response-alternative-link': 'onResponseAlternative'
      'click .response-weight': 'onResponseWeight'
      'click .response-new-button': 'onResponseNewButton'
      'mouseenter .response': 'onResponseHover'

    initialize: (options) ->
      $(window).on 'scenario:change', _.bind @onScenarioChange, @

      @template = _.template $("#responses-template").html()
      @options = options
      @recalculateScenarioBranchesInit()
      @

    render: ->

      @

    renderResponse: (response) ->
      responseView = new ReponseView
        model: response
      @$responses.append responseView.render().el

    onResponseDelete: (e) -> confirm($(e.target).find('.btn').data('confirm'))

    onResponseHover: (e) -> 
      $response = $ e.currentTarget
      
      @responseAlternative $response if !$response.hasClass 'response-active'

    onResponseAlternative: (e) ->
      $el = $ e.currentTarget
      $response = $el.parents '.response'
      @responseAlternative $response

      false

    responseAlternative: ($response) ->
      @removeResponseHightlight()

      $response.addClass 'response-active'

      @responseAlternativeCollection = null

      if !@responseAlternativeView
        @responseAlternativeView = null
      else 
        @responseAlternativeView.undelegateEvents()

      
      @responseAlternativeCollection = new ResponseCollection
        url: $response.data 'alt-url'
        success: ->
          $(window).trigger 'scenario-branches:updated'

      @responseAlternativeView = new ResponsesAlternativeView
        collection: @responseAlternativeCollection

      @responseAlternativeCollection.fetch()

    removeResponseHightlight: ->
      @$el.find('#scenario-current-responses').find('.response').removeClass 'response-active'

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

    onResponseNewButton: (e) ->
      $el = $ e.currentTarget

      templateCreateForm = _.template $('#responses-create-form-template').html()

      $form = $ templateCreateForm
        parent_id: 0 || $el.data 'parent_id'
        scene_id: $el.data 'scene_id'

      $el.parent().empty().append $form

      $form.find('textarea').focus()

      false
    ,

    onResponsePost: (e) ->
      $form = $ e.target
      url = $form.attr 'action'

      responseCollection = new ResponseCollection
        url: url

      responseCollection.create
        response:
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

    recalculateScenarioBranchesInit: ->
      $window = $ window
      $el = @$('#scenario-branches-wrap')
      pos = @getScenarioBranchesPosition()

      $el.css
        position: 'absolute'
        top: pos

      setInterval _.bind(@recalculateScenarioBranches, @), 100

      @

    recalculateScenarioBranches: (e) ->
      $window = $ window
      $el = @$ '#scenario-branches-wrap'
      $wrap = @$ '#scenario-branches'
      $footer = $ '#footer'
      pos = @getScenarioBranchesPosition()
      footerPosition = $footer.position().top
      scrollTop = $window.scrollTop()
      height = $window.height()

      if scrollTop < pos
        $el.css
          position: 'absolute'
          top: pos
      else
        $el.css
          position: 'fixed'
          top: 0
      
      if footerPosition - scrollTop < height
        height = footerPosition - scrollTop

      if pos > scrollTop
        height = height - (pos - scrollTop)

      $wrap.css
        height: height

    getScenarioBranchesPosition: ->
      $el = @$('#scenario-current')
      if $el.length > 0
        $el.position().top
      else
        0
