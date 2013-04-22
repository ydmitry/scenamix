define (require) ->

  AlternativeResponsesView = require 'views/responses/responses_alternative'
  ResponseModel = require 'models/response'

  describe 'Alternative Responses view', ->
    it 'renders', ->

      response =
        id: 10
        scene_id: 11
        parent_id: 9
        response: "Some response"
        votes: 1
        created_at: '10.10.2013'
        user_name: 'User1'
        alternative_size: 10
        responses_size: 4

      fakeData =
        id: 1
        scene_id: 11
        parent_id: 9
        response: "Some response"
        votes: 1
        created_at: '10.10.2013'
        user_name: 'User1'
        alternative_size: 10
        responses: [response]

      spyOn($, "ajax").andCallFake (params) ->
        params.success fakeData

      model = new ResponseModel {},
        url: '/scenes/5/responses/1/alternative'

      responsesView = new AlternativeResponsesView
        el: $ '<div />'
        model: model
      
      model.fetch()

      expect(responsesView.$el.find('#responses-alternative').find('.response').length == 1).toBeTruthy()

      
