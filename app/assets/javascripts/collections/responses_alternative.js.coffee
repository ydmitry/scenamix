define ['backbone', 'models/response_alternative'], (Backbone, ResponseAlternativeModel) ->
  ResponseAlternativeCollection = Backbone.Collection.extend
    model: ResponseAlternativeModel
    initialize: (models, options) ->
      if !!options.url      
        @url = options.url
