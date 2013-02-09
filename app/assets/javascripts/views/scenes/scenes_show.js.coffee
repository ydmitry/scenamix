define (require) ->

  require ['jquery', 'underscore', 'backbone'], ($, _, Backbone) ->  
  
  ResponseAlternativeView    = require 'views/responses/response_alternative'
  ResponseCollection    = require 'collections/responses'

  class SceneShow extends Backbone.View
    
    el: '#layout-content-container'

    events:
      
      'submit .response-delete': 'onResponseDelete'
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
    
    addRow: (response) ->
      @$responses.append @templateItem response.toJSON()

    onResponseDelete: (e) -> confirm($(e.target).find('.btn').data('confirm'))
      
    onResponseAlternative: (e) ->
      $el = $ e.currentTarget
      
      @responseCollection = null
      
      if !@responseAlternativeView
        @responseAlternativeView = null
      else 
        @responseAlternativeView.undelegateEvents()
      
      @responseCollection = new ResponseCollection
        url: $el.attr 'href'
        
      @responseAlternativeView = new ResponseAlternativeView
        collection: @responseCollection
      
      @responseCollection.fetch()
      

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
      

      false
    
    onScenarioChangeLoad: (responseCollection) ->
      @$responsesWrap = @.$ '#scenario-responses-wrap'

      @$responsesWrap.empty()

      @$responses = $ '<div />'
      
      responseCollection.each _.bind @addRow, this

      $rendered = $ @template responseCollection.last().toJSON()
      
      $rendered.find("#scenario-current-responses").append @$responses
      
      @$responsesWrap.append $rendered

      false

    SceneShow
