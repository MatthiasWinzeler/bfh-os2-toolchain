BfhOs2Toolchain.PostNewController = Ember.ObjectController.extend
  headerTitle: 'Create'
  buttonTitle: 'Create'

  actions:
    save: ->
      @content.save().then =>
        @transitionToRoute('post', @content)

    cancel: ->
      @content.deleteRecord()
      @transitionToRoute('posts')
