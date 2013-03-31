define (require) ->

  Router = require 'routers/scenes_router'

  MockRouter = Router.extend
    navigate: (fragment, options) ->
      @fragment = fragment

  describe 'Scenes router', ->
    it 'navigate to scenario url when it changed', ->

      mockRouter = new MockRouter

      uri = '/scenes/1/responses/2'
      $(window).trigger 'scenario:changed', uri
      expect(mockRouter.fragment).toEqual uri;

