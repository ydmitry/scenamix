define (require) ->

  ResponseView = require 'views/responses/response'

  describe 'Response view', ->
    it 'renders', ->

      model = new Backbone.Model
        id: 10
        scene_id: 11
        parent_id: 9
        response: "Some response"

      responseView = new ResponseView
        model: model

      responseView.render()

      expect(responseView.$el).toHaveClass 'response'
