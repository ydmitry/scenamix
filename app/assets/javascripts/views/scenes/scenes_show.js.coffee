define ['jquery', 'underscore', 'backbone', 'views/responses/responses_alternative', 'collections/responses', 'views/responses/response'], ($, _, Backbone, ResponsesAlternativeView, ResponseCollection, ReponseView) ->
  ScenesShow = Backbone.View.extend

    el: '#layout-content-container'

    events:

      'submit .response-delete': 'onResponseDelete'
      'submit #response-post-form': 'onResponsePost'
      'click .response-alternative-link': 'onResponseAlternative'
      'click .response-weight': 'onResponseWeight'
      'click .response-new-button': 'onResponseNewButton'
      'mouseenter .response': 'onResponseHover'

    initialize: (options) ->
      $(window).on 'scenario:change', _.bind @onScenarioChange, @

      @template = _.template $("#responses-template").html()
      @options = options
      @scrollScenarioBranchesFollowFrom()
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
      $el = $response.find '.response-alternative-link'

      @removeResponseHightlight()      

      $response.addClass 'response-active'

      @responseAlternativeCollection = null

      if !@responseAlternativeView
        @responseAlternativeView = null
      else 
        @responseAlternativeView.undelegateEvents()

      if $el.length !=0
        @responseAlternativeCollection = new ResponseCollection
          url: $el.attr 'href'
          success: ->
            $(window).trigger 'scenario-branches:updated'

        @responseAlternativeView = new ResponsesAlternativeView
          collection: @responseAlternativeCollection

        @responseAlternativeCollection.fetch()

      else if !!@responseAlternativeView
        @responseAlternativeView.$el.hide().empty()

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

    scrollScenarioBranchesFollowFrom: ->
        $el = @$('#scenario-branches-wrap')
        pos = @responseListPosition()
        $window = $ window

        $wrap = @$ '#responses-alternative-wrap'

        $el.css
          position: 'absolute'
          top: pos

        @responsesAlternativeWrapUpdate()

        $window.scroll _.bind (e) ->
          if $window.scrollTop() < pos
            $el.css
              position: 'absolute'
              top: pos
          else
            $el.css
              position: 'fixed'
              top: 0
          @responsesAlternativeWrapUpdate()
        , @
        
        @


    responseListPosition: ->
      @$('#scenario-current').find('.response:first').position().top - 40

    responsesAlternativeWrapUpdate: ->
      $window = $ window
      pos = @responseListPosition()
      $wrap = @$ '#scenario-branches'
      $footer = $ '#footer'
      footerPosition = $footer.position().top
      scrollTop = $window.scrollTop()
      height = $window.height()

      if footerPosition < height + scrollTop
        height = height - (height + scrollTop - footerPosition)

      if pos > scrollTop
        height = height - (pos - scrollTop)

      $wrap.css
        height: height

      @
