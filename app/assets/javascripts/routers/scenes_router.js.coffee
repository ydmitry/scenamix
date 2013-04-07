define ['jquery', 'underscore', 'backbone', 'views/scenes/scenes_show'], ($, _, Backbone, ScenesShowView) ->
  Router = Backbone.Router.extend

    routes:
      # When there is no url, the home method is called
      "": "home"

      "scenes": "scenes"

      "scenes/:scene": "sceneShow"

      "scenes/:scene/responses/:response": "sceneShow"

    initialize: (options) ->
      @options = options

      # Enable pushState for compatible browsers
      enablePushState = true

      # Disable for older browsers
      pushState = !!(enablePushState && window.history && window.history.pushState)

      # Tells Backbone to start watching for hashchange events
      Backbone.history.start({pushState: pushState})

      $(window).on 'scenario:changed', _.bind @onScenarioChanged, @

    home: ->
      false

    scenes: ->
      false

    sceneShow: (scene) ->
      sceneView = new ScenesShowView
        sceneId: scene

    onScenarioChanged: (e, url)->
      @navigate url

    # Returns the Router class
