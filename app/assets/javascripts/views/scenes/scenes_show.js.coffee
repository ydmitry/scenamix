define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'

  ->

  class SceneShow extends Backbone.View
    
    el: '#layout-content-container'    
  
    render: ->
      
      console.log "SceneShow rendered"
    
    SceneShow
