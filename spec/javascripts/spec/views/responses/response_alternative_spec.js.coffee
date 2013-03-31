define (require) ->

  ResponseAlternativeView = require 'views/responses/response_alternative'

  describe 'Response alternative view', ->
    it 'renders', ->

      model = new Backbone.Model
        id: 10
        scene_id: 11
        parent_id: 9
        response: "Some response",
        votes: 1,
        created_at: '10.10.2013',
        alternative_size: 10

      responseAlternativeView = new ResponseAlternativeView
        model: model

      responseAlternativeView.render()

      expect(responseAlternativeView.$el.hasClass('response')).toBeTruthy()
