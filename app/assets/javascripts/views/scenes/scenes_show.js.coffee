define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'

  ->

  class SceneShow extends Backbone.View
    
    el: '#layout-content-container'

    events:
      
      'submit .response-delete': 'onResponseDelete'
      'click .response-alternative': 'onResponseAlternative'
  
    render: ->
      
      console.log "SceneShow rendered"
    
    onResponseDelete: (e) -> confirm($(e.target).find('.btn').data('confirm'))
      
    onResponseAlternative: (e) ->
      $el = $(e.currentTarget)
      $.ajax $el.attr('href'),
        dataType: 'json'
        success: this.onResponseAlternativeLoad
          
      false

    onResponseAlternativeLoad: (data) ->
      false


    SceneShow
