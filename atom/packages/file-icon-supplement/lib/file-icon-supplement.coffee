FileIconSupplementView = require './file-icon-supplement-view'

module.exports =
  configDefaults:
    treeViewIcons: true
    tabIcons: true
    fuzzyFinderIcons: true
    findAndReplaceIcons: true
    grammarStatusIcons: true
    grammarSelectorIcons: true

  fileIconSupplementView: null

  activate: (state) ->
    @fileIconSupplementView =
      new FileIconSupplementView state.fileIconSupplementViewState
    atom.packages.once "activated", =>
      @fileIconSupplementView.loadAllSettings()

  deactivate: ->
    @fileIconSupplementView.destroy()

  serialize: ->
    fileIconSupplementViewState: @fileIconSupplementView.serialize()
