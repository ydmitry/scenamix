define ['backbone', 'models/response'], (Backbone, ResponseModel) ->
  ResponseCollection = Backbone.Collection.extend
    model: ResponseModel

    initialize: (models, options) ->
      if !!options && !!options.url      
        @url = options.url

