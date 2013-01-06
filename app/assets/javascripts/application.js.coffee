requirejs.config
  shim:
    'backbone':
      deps: ['underscore', 'jquery'],
      exports: 'Backbone'
    'bootstrap':
      deps: ['jquery','twitter/bootstrap/bootstrap-popover']
    'twitter/bootstrap/bootstrap-popover':
      deps: ['jquery', 'twitter/bootstrap/bootstrap-tooltip']
    'twitter/bootstrap/bootstrap-tooltip':
      deps: ['jquery']


require ['jquery', 'underscore', 'backbone', 'bootstrap'], ($, _, Backbone, Bootstrap) ->
#  Start up the app once the DOM is ready
  $ -> 
    Backbone.history.start
      pushState: true
    
