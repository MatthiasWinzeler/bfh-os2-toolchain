BfhOs2Toolchain.PostsRoute = Ember.Route.extend
  model: ->
    BfhOs2Toolchain.Post.find()
