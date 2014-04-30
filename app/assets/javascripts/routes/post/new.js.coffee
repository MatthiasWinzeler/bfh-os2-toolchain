BfhOs2Toolchain.PostNewRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    controller.set('content', model)

  model: ->
    BfhOs2Toolchain.Post.createRecord {}
)
