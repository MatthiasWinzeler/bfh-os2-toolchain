# For more information see: http://emberjs.com/guides/routing/

BfhOs2Toolchain.Router.map ()->
  @resource "posts",
    path: "/posts"

  @resource "posts", ->
    @route "post",
      path: "/post/:id"

    return

  @resource "post.new",
    path: "/post/new"

  @resource "post.delete",
    path: "/post/delete"

  @resource "post",
    path: "/post/:id", ->
      @route "edit"
      return

    path: "/post/delete/:id", ->
      @route "delete"
      return

  return
