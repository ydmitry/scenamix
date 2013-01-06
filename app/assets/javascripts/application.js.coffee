require ['jquery', 'underscore', 'backbone', 'bootstrap'], ($, _, Backbone, Bootstrap) ->
#  Start up the app once the DOM is ready
  $ -> 
    Backbone.history.start
      pushState: true
    
