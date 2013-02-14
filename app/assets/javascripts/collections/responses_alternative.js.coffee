define ['backbone', 'models/response_alternative'], (Backbone, ResponseAlternativeModel) ->
  ResponseAlternativeCollection = Backbone.Collection.extend
    model: ResponseAlternativeModel
