BfhOs2Toolchain.PostDeleteRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    controller.set('content', model)
)
