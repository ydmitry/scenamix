define ['jquery', 'backbone'], ($, Backbone) ->
  CurrentUser = Backbone.Model.extend()

  currentUser = new CurrentUser
  currentUser.set
    id: $('#current-user-id').val()
    admin: $('#current-user-admin').val()

  currentUser
