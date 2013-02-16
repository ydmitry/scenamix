define ['jquery', 'underscore', 'backbone', 'views/responses/responses_alternative', 'collections/responses'], ($, _, Backbone, ResponsesAlternativeView, ResponseCollection) ->
  ScenesShow = Backbone.View.extend
    
    el: '#layout-content-container'

    events:
      
      'submit .response-delete': 'onResponseDelete'
      'submit #response-post-form': 'onResponsePost'
      'click .response-alternative': 'onResponseAlternative'
      'click .response-weight': 'onResponseWeight'
    
    initialize: (options) ->
      $(window).on 'scenario:change', _.bind @onScenarioChange, @
      @template = _.template $("#responses-template").html()
      @templateItem = _.template $("#response-item-template").html()
      @options = options
      @

    render: ->
      
      console.log "SceneShow rendered"
      
      @
    
    renderResponse: (response) ->
      @$responses.append @templateItem response.toJSON()

    onResponseDelete: (e) -> confirm($(e.target).find('.btn').data('confirm'))
      
    onResponseAlternative: (e) ->
      $el = $ e.currentTarget

      $response = $el.parents '.response'
      
      @$el.find('.response').addClass 'alert-info'      
      
      $response.removeClass 'alert-info'

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
      

      false

    onResponseWeight: (e) ->
      $el = $ e.currentTarget
      url = $el.attr('href')
      $.ajax url,
        type: 'put'
        success: (data) ->          
          $el.siblings('.response-weight-value').html '+'+data.upvotes+'-'+data.downvotes

      false

    onScenarioChange: (e, url) ->
      
      responseCollection = new ResponseCollection
        url: url 
      
      responseCollection.fetch
        success: _.bind @onScenarioChangeLoad, @
      
      $(window).trigger 'scenario:changed', url

      false
    
    onScenarioChangeLoad: (responseCollection) ->
      @$responsesWrap = @.$ '#scenario-responses-wrap'

      @$responsesWrap.empty()

      @$responses = $ '<div />'
      
      responseCollection.each @renderResponse, this

      responseLast = responseCollection.last()

      $rendered = $ @template
        parent_id: responseLast.get('id')
        scene_id: responseLast.get('scene_id')
      
      $rendered.find("#scenario-current-responses").append @$responses
      
      @$responsesWrap.append $rendered
      
      @responseAlternativeCollection = null

      if !!@responseAlternativeView
        @responseAlternativeView.$el.empty()

      false

    onResponsePost: (e) ->
      $form = $(e.target)
      url = $form.attr 'action'

      responseCollection = new ResponseCollection
        url: url

      responseCollection.create
        response:
          response: $form.find('textarea').val()
          parent_id: $form.find('#response_parent_id').val()
      ,
        success: _.bind (response) ->
          responseCollection = new ResponseCollection
            url: '/scenes/' + response.get('scene_id') + '/responses/' + response.get('id')
          responseCollection.fetch
            success: _.bind @onScenarioChangeLoad, @
        , @


      false

