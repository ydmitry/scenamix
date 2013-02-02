define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'

  ->

  class SceneShow extends Backbone.View
    
    el: '#layout-content-container'

    events:
      
      'submit .response-delete': 'onResponseDelete'
  
    render: ->
      
      console.log "SceneShow rendered"
    
    onResponseDelete: (e) -> confirm($(e.target).find('.btn').data('confirm'))
      

    SceneShow
