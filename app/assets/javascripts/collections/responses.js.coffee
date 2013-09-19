define ['backbone', 'models/response'], (Backbone, ResponseModel) ->
  ResponseCollection = Backbone.Collection.extend
    model: ResponseModel
