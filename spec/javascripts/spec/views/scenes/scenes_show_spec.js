define (require) ->

  _ = require 'underscore'
  ScenesShowView = require 'views/scenes/scenes_show'

  describe 'Scenes show view', ->
    it 'renders', ->

      scenesShowView = new ScenesShowView

      uri = '/scenes/1/responses/2'
      $(window).trigger 'scenario:changed', uri
      expect(mockRouter.fragment).toEqual uri;

