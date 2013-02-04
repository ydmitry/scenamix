define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  
  ResponseAlternativeView    = require 'views/responses/response_alternative'
  ResponseCollection    = require 'collections/responses'

  ->

  class SceneShow extends Backbone.View
    
    el: '#layout-content-container'

    events:
      
      'submit .response-delete': 'onResponseDelete'
      'click .response-alternative': 'onResponseAlternative'
      'click .response-weight': 'onResponseWeight'
  
    render: ->
      
      console.log "SceneShow rendered"
    
    onResponseDelete: (e) -> confirm($(e.target).find('.btn').data('confirm'))
      
    onResponseAlternative: (e) ->
      $el = $ e.currentTarget

      responseCollection = new ResponseCollection
        url: $el.attr 'href'
        

      responseAlternativeView = new ResponseAlternativeView
        collection: responseCollection
      
      responseCollection.fetch()
      
      false

    onResponseWeight: (e) ->
      $el = $ e.currentTarget
      url = $el.attr('href')
      $.ajax url,
        type: 'put'
        success: (data) ->          
          $el.siblings('.response-weight-value').html data.weight       

      false

    SceneShow
