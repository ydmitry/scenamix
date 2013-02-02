require ['jquery', 'underscore', 'backbone', 'bootstrap', 'routers/scenes_router'], ($, _, Backbone, Bootstrap, Router) ->
#  Start up the app once the DOM is ready
  $ -> 
    
    router = new Router
