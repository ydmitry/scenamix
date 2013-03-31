define ['backbone', 'models/response'], (Backbone, ResponseModel) ->
  ResponseCollection = Backbone.Collection.extend
    model: ResponseModel

    initialize: (options) ->
      if !!options.url      
        @url = options.url

