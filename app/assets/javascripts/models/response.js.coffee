define ['underscore', 'backbone', 'collections/responses_alternative'], (_, Backbone, ResponsesCollection) ->
  ResponseModel = Backbone.Model.extend
    initialize: (attributes, options) ->
      if !!options && !!options.url      
        @url = options.url
      if !_.isEmpty attributes
        @parseAttributes attributes
    parse: (r) ->
      r = @parseAttributes r
      r
    parseAttributes: (r) ->
      if _.has r, 'responses'
        if @responses
          @responses.reset r.responses
        else
          @responses = new ResponsesCollection r.responses, 
            url: @url
          delete r.responses
      r
