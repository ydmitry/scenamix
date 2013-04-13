define ['jquery', 'underscore', 'backbone', 'views/responses/responses_alternative', 'views/responses/response', 'models/response', 'collections/responses'], ($, _, Backbone, ResponsesAlternativeView, ReponseView, ResponseModel, ResponseCollection) ->
  ScenesShow = Backbone.View.extend

    el: '#layout-content-container'

    events:

      'submit .response-delete': 'onResponseDelete'
      'submit .scene-delete': 'onSceneDelete'
      'submit .response-post-form': 'onResponsePost'
      'click .response-alternative-link': 'onResponseAlternative'
      'click .response-weight': 'onResponseWeight'
      'click .response-new-button': 'onResponseNewButton'
      'mouseenter .response-scenario': 'onResponseHover'

    initialize: (options) ->
      $(window).on 'scenario:change', _.bind @onScenarioChange, @

      @template = _.template $.trim $("#responses-template").html()
      @options = options
      @recalculateScenarioBranchesInit()
      $('body').append '<div id="right-overlay"></div>'
      @

    render: ->
      $response = @$('.response:first')
      @responseAlternative($response) if $response.length > 0
      @

    renderResponse: (response) ->
      responseView = new ReponseView
        model: response
      @$responses.append responseView.render().el

    onSceneDelete: (e) -> confirm($(e.target).find('.btn').data('confirm'))

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

      @activeResponseModel = null

      if !@responseAlternativeView
        @responseAlternativeView = null
      else 
        @responseAlternativeView.undelegateEvents()

      
      @activeResponseModel = new ResponseModel
        url: $response.data 'alt-url'
        success: ->
          $(window).trigger 'scenario-branches:updated'

      @responseAlternativeView = new ResponsesAlternativeView
        model: @activeResponseModel

      @activeResponseModel.fetch
        parse: true

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

      @activeResponseModel = null

      if !!@responseAlternativeView
        @responseAlternativeView.$el.empty()

      $response = @$('.response:first')
      @responseAlternative($response) if $response.length > 0

      false

    onResponseNewButton: (e) ->
      $el = $ e.currentTarget

      templateCreateForm = _.template $.trim $('#responses-create-form-template').html()

      $form = $ templateCreateForm
        parent_id: 0 || $el.data 'parent_id'
        scene_id: $el.data 'scene_id'

      $el.parents('.response,.scene').find('.response-new-container').append $form
      $el.parent().empty()

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
        top: 0

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
      else
        $el.css
          position: 'fixed'
      
      if footerPosition - scrollTop < height
        height = footerPosition - scrollTop

      if pos > scrollTop
        height = height - (pos - scrollTop)

      $wrap.css
        height: height

    getScenarioBranchesPosition: ->
      $('#header').height()
