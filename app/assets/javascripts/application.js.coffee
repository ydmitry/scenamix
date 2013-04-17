require ['jquery', 'underscore', 'backbone', 'routers/scenes_router'], ($, _, Backbone, Router) ->
#  Start up the app once the DOM is ready
  $ ->
    _.templateSettings =
      interpolate: /\{\{\=(.+?)\}\}/g
      evaluate: /\{\{(.+?)\}\}/g

    $('#current-user-sign-out').click () ->
      $.ajax '/users/sign_out',
        type: 'delete',
        success: ->
          window.location.reload()
      false

    router = new Router
