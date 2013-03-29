define (require) ->

  ResponseAlternativeView = require 'views/responses/response_alternative'

  describe 'Response alternative view', ->
    it 'renders', ->

      model = new Backbone.Model
        id: 10
        scene_id: 11
        parent_id: 9
        response: "Some response",
        upvotes: 1,
        downvotes: 0

      responseAlternativeView = new ResponseAlternativeView
        model: model

      responseAlternativeView.render()

      expect(responseAlternativeView.$el.hasClass('response')).toBeTruthy()
