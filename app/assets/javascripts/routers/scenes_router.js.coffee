define ['jquery', 'underscore', 'backbone', 'views/scenes/scenes_show'], ($, _, Backbone, ScenesShowView) ->
  Router = Backbone.Router.extend

    routes:
      # When there is no url, the home method is called
      "": "home"
      "sign_in": "signIn"
      "users/sign_up": "signUp"
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

      if !pushState
        mainRouter.navigate window.location.pathname.replace(/^\//, ''),
          trigger: true
          replace: false

    home: ->
      false

    scenes: ->
      false

    sceneShow: (scene) ->
      sceneView = new ScenesShowView
        sceneId: scene
      sceneView.render()

    signIn: ->
      $('input[type="email"]:first').focus()

    signUp: ->
      $('input[type="email"]:first').focus()

    onScenarioChanged: (e, url)->
      @navigate url

    # Returns the Router class
