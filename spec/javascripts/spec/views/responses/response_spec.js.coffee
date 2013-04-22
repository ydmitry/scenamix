define (require) ->

  ResponseView = require 'views/responses/response'

  describe 'Response view', ->
    it 'renders', ->

      model = new Backbone.Model
        id: 10
        scene_id: 11
        parent_id: 9
        response: "Some response"
        votes: 1
        created_at: '10.10.2013'
        user_name: 'User1'
        alternative_size: 10

      responseView = new ResponseView
        model: model

      responseView.render()

      expect(responseView.$el.hasClass('response')).toBeTruthy()
