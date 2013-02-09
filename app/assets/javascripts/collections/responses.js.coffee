define (require) ->

  $             = require 'jquery'
  _             = require 'underscore'
  Backbone      = require 'backbone'
  ResponseModel = require 'models/response'
  ->

  class ResponseCollection extends Backbone.Collection
    
    model: ResponseModel

    initialize: (options) ->
      if !!options.url      
        @url = options.url

    ResponseCollection
