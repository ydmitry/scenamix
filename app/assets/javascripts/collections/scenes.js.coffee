define ['backbone', 'models/scene'], (Backbone, SceneModel) ->
  SceneCollection = Backbone.Collection.extend
    model: SceneModel
