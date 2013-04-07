define ['jquery', 'backbone'], ($, Backbone) ->
  CurrentUser = Backbone.Model.extend()

  currentUser = new CurrentUser
  currentUser.set
    id: parseInt($('#current-user-id').val())
    admin: parseInt($('#current-user-admin').val())

  currentUser
