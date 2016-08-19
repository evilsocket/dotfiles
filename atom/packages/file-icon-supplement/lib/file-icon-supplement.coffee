FileIconSupplementView = require './file-icon-supplement-view'

module.exports =

  config:
    treeViewIcons:
      type: 'boolean'
      default: true
    tabIcons:
      type: 'boolean'
      default: true
    fuzzyFinderIcons:
      type: 'boolean'
      default: true
    findAndReplaceIcons:
      type: 'boolean'
      default: true
    grammarStatusIcons:
      type: 'boolean'
      default: true
    grammarSelectorIcons:
      type: 'boolean'
      default: true

  fileIconSupplementView: null

  activate: (state) ->
    atom.packages.onDidActivateInitialPackages () =>
      @fileIconSupplementView =
        new FileIconSupplementView state.fileIconSupplementViewState

  deactivate: ->
    @fileIconSupplementView.destroy()

  serialize: ->
    fileIconSupplementViewState: @fileIconSupplementView.serialize()
