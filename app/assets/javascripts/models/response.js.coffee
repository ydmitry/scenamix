define ['underscore', 'backbone', 'collections/responses_alternative'], (_, Backbone, ResponsesCollection) ->
  ResponseModel = Backbone.Model.extend
    initialize: (options) ->
      if !!options.url      
        @url = options.url
    parse: (r) ->
      if _.has r, 'responses'
        if @responses
          @responses.reset r.responses
        else
          @responses = new ResponsesCollection r.responses
          delete r.responses
      r
