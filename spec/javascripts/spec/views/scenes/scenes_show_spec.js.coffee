define (require) ->

  _ = require 'underscore'
  ScenesShowView = require 'views/scenes/scenes_show'

  describe 'Scenes show view', ->
    it 'renders', ->

      scenesShowView = new ScenesShowView

      scenesShowView.render()
