{View} = require 'atom'

module.exports =
class FileIconSupplementView extends View

  @content: ->
    @div class: 'fis'

  initialize: (serializeState) ->
    atom.workspaceView.command 'file-icon-supplement:addTabClass',
      => @addTabClass()
    atom.workspaceView.command 'file-icon-supplement:removeTabClass',
      => @removeTabClass()
    atom.workspaceView.command 'file-icon-supplement:toggleTabClass',
      => @toggleClass 'tabIcons'
    atom.workspaceView.command 'file-icon-supplement:addTreeViewClass',
      => @addTreeViewClass()
    atom.workspaceView.command 'file-icon-supplement:removeTreeViewClass',
      => @removeTreeViewClass()
    atom.workspaceView.command 'file-icon-supplement:toggleTreeViewClass',
      => @toggleClass 'treeViewIcons'
    atom.workspaceView.command 'file-icon-supplement:addFuzzyFinderClass',
      => @addFuzzyFinderClass()
    atom.workspaceView.command 'file-icon-supplement:removeFuzzyFinderClass',
      => @removeFuzzyFinderClass()
    atom.workspaceView.command 'file-icon-supplement:toggleFuzzyFinderClass',
      => @toggleClass 'fuzzyFinderIcons'
    atom.workspaceView.command 'file-icon-supplement:addFindAndReplaceClass',
      => @addFindAndReplaceClass()
    atom.workspaceView.command 'file-icon-supplement:removeFindAndReplaceClass',
      => @removeFindAndReplaceClass()
    atom.workspaceView.command 'file-icon-supplement:toggleFindAndReplaceClass',
      => @toggleClass 'findAndReplaceIcons'
    atom.workspaceView.command 'file-icon-supplement:addGrammarStatusClass',
      => @addGrammarStatusClass()
    atom.workspaceView.command 'file-icon-supplement:removeGrammarStatusClass',
      => @removeGrammarStatusClass()
    atom.workspaceView.command 'file-icon-supplement:toggleGrammarStatusClass',
      => @toggleClass 'grammarStatusIcons'
    atom.workspaceView.command 'file-icon-supplement:addGrammarSelectorClass',
      => @addGrammarSelectorClass()
    atom.workspaceView.command 'file-icon-supplement:removeGrammarSelectorClass',
      => @removeGrammarSelectorClass()
    atom.workspaceView.command 'file-icon-supplement:toggleGrammarSelectorClass',
      => @toggleClass 'grammarSelectorIcons'
    atom.workspaceView.command 'file-icon-supplement:removeAllClass',
      => @removeAllClass()
    atom.workspaceView.command 'file-icon-supplement:toggleAllClass',
      => @toggleClass()

    @subscribe atom.config.observe 'file-icon-supplement.tabIcons',
      => @loadTabSettings()
    @subscribe atom.config.observe 'file-icon-supplement.treeViewIcons',
      => @loadTreeViewSettings()
    @subscribe atom.config.observe 'file-icon-supplement.fuzzyFinderIcons',
      => @loadFuzzyFinderSettings()
    @subscribe atom.config.observe 'file-icon-supplement.findAndReplaceIcons',
      => @loadFindAndReplaceSettings()
    @subscribe atom.config.observe 'file-icon-supplement.grammarStatusIcons',
      => @loadGrammarStatusSettings()

    @subscribe atom.config.observe 'tabs.showIcons',
      => @loadTabSettings()
    @subscribe atom.config.observe 'tree-view.hideVcsIgnoredFiles',
      => @loadTreeViewSettings()
    @subscribe atom.config.observe 'tree-view.hideIgnoredNames',
      => @loadTreeViewSettings()

    @subscribe atom.workspaceView, 'project-find:show',
      => @addFindAndReplaceEvent()
    @subscribe atom.workspaceView, 'fuzzy-finder:toggle-file-finder',
      => @loadFuzzyFinderSettings()
    @subscribe atom.workspaceView, 'grammar-selector:show',
      => @loadGrammarSelectorSettings()
    @subscribe atom.workspace.paneContainer.emitter, 'did-change-active-pane-item',
      => @addTabClass()

    treeView = atom.packages.loadedPackages['tree-view'] or
      atom.packages.loadedPackages['sublime-tabs']

    @subscribe treeView.mainModule.treeView, 'tree-view:directory-modified',
      => @addTreeViewClass()

  serialize: ->

  destroy: -> @detach()

  addTabClass: ->
    target = atom.workspaceView.find 'ul.tab-bar li.tab .title:not(.hide-icon)'
    target.addClass 'fis fis-tab'
    @reloadStyleSheets()

  removeTabClass: ->
    target = atom.workspaceView.find '.fis.fis-tab'
    target.removeClass 'fis fis-tab'

  loadTabSettings: ->
    if atom.config.get 'file-icon-supplement.tabIcons'
      @addTabClass()
    else
      @removeTabClass()

  addTreeViewClass: ->
    target = atom.workspaceView.find 'ol.tree-view span.name.icon'
    target.addClass 'fis fis-tree'
    @reloadStyleSheets()

  removeTreeViewClass: ->
    target = atom.workspaceView.find '.fis.fis-tree'
    target.removeClass 'fis fis-tree'

  loadTreeViewSettings: ->
    if atom.config.get 'file-icon-supplement.treeViewIcons'
      @addTreeViewClass()
    else
      @removeTreeViewClass()

  addFuzzyFinderClass: ->
    target = atom.workspaceView.find '.fuzzy-finder .file.icon'
    target.addClass 'fis fis-fuzzy'
    @reloadStyleSheets()

  removeFuzzyFinderClass: ->
    target = atom.workspaceView.find '.fis.fis-fuzzy'
    target.removeClass 'fis fis-fuzzy'

  toggleFuzzyFinderClass: ->
    current = atom.config.get 'file-icon-supplement.FuzzyFinderIcons'
    atom.config.set 'file-icon-supplement.fuzzyFinderIcons', !current

  loadFuzzyFinderSettings: ->
    if atom.config.get 'file-icon-supplement.fuzzyFinderIcons'
      @addFuzzyFinderClass()
    else
      @removeFuzzyFinderClass()

  addFindAndReplaceClass: ->
    target = atom.workspaceView.find '.results-view span.icon'
    target.addClass 'fis fis-find'
    @reloadStyleSheets()

  removeFindAndReplaceClass: ->
    atom.workspace.eachEditor ->
      target = atom.workspaceView.find '.fis.fis-find'
      target.removeClass 'fis fis-find'

  loadFindAndReplaceSettings: ->
    if atom.config.get 'file-icon-supplement.findAndReplaceIcons'
      @addFindAndReplaceClass()
    else
      @removeFindAndReplaceClass()
      @removeFindAndReplaceEvent()

  addFindAndReplaceEvent: ->
    if atom.packages.loadedPackages['find-and-replace'] and
    atom.config.get 'file-icon-supplement.findAndReplaceIcons'
      @subscribe atom.packages.loadedPackages['find-and-replace'].
        mainModule.resultsModel.emitter, 'did-finish-searching', =>
          @addFindAndReplaceClass()

  removeFindAndReplaceEvent: ->
    if atom.packages.loadedPackages['find-and-replace']
      @unsubscribe atom.packages.loadedPackages['find-and-replace'].
        mainModule.resultsModel.emitter, 'did-finish-searching', =>
          @addFindAndReplaceClass()

  addGrammarStatusClass: ->
    target = atom.workspaceView.find '.grammar-status a'
    target.addClass 'fis fis-grammar-status'
    @reloadStyleSheets()

  removeGrammarStatusClass: ->
    target = atom.workspaceView.find '.fis.fis-grammar-status'
    target.removeClass 'fis fis-grammar-status'

  loadGrammarStatusSettings: ->
    if atom.config.get 'file-icon-supplement.grammarStatusIcons'
      @addGrammarStatusClass()
    else
      @removeGrammarStatusClass()

  addGrammarSelectorClass: ->
    target = atom.workspaceView.find '.grammar-selector li'
    target.addClass 'fis fis-grammar-selector'
    @reloadStyleSheets()

  removeGrammarSelectorClass: ->
    target = atom.workspaceView.find '.fis.fis-grammar-selector'
    target.removeClass 'fis fis-grammar-selector'

  loadGrammarSelectorSettings: ->
    if atom.config.get 'file-icon-supplement.grammarSelectorIcons'
      @addGrammarSelectorClass()
    else
      @removeGrammarSelectorClass()

  removeAllClass: ->
    target = atom.workspaceView.find '.fis'
    target.removeClass 'fis fis-tree fis-tab fis-fuzzy fis-find fis-grammar-status fis-grammar-selector'

  loadAllSettings: ->
    @loadTabSettings()
    @loadTreeViewSettings()
    @loadFuzzyFinderSettings()
    @loadFindAndReplaceSettings()
    @loadGrammarStatusSettings()
    @loadGrammarSelectorSettings()

  toggleClass: (area) ->
    if area
      setting = 'file-icon-supplement.' + area
      value = atom.config.get setting
      atom.config.set setting, !value
    else if @isToggledOn()
      @setToggleClassCache()
      @disableAllSettings()
    else
      @recoverToggleClassCache()

  isToggledOn: ->
    atom.config.get('file-icon-supplement.tabIcons') or
    atom.config.get('file-icon-supplement.treeViewIcons') or
    atom.config.get('file-icon-supplement.fuzzyFinderIcons') or
    atom.config.get('file-icon-supplement.findAndReplaceIcons') or
    atom.config.get('file-icon-supplement.grammarStatusIcons') or
    atom.config.get('file-icon-supplement.grammarSelectorIcons')

  toggleClassCache: {}

  setToggleClassCache: ->
    @toggleClassCache =
      tabIcons: atom.config.get 'file-icon-supplement.tabIcons'
      treeViewIcons: atom.config.get 'file-icon-supplement.treeViewIcons'
      fuzzyFinderIcons: atom.config.get 'file-icon-supplement.fuzzyFinderIcons'
      findAndReplaceIcons: atom.config.get(
        'file-icon-supplement.findAndReplaceIcons')
      grammarStatusIcons: atom.config.get 'file-icon-supplement.grammarStatusIcons'
      grammarSelectorIcons: atom.config.get 'file-icon-supplement.grammarSelectorIcons'

  recoverToggleClassCache: ->
    for key, value of @toggleClassCache
      atom.config.set 'file-icon-supplement.' + key, value

  disableAllSettings: ->
    atom.config.set 'file-icon-supplement.tabIcons', false
    atom.config.set 'file-icon-supplement.treeViewIcons', false
    atom.config.set 'file-icon-supplement.fuzzyFinderIcons', false
    atom.config.set 'file-icon-supplement.findAndReplaceIcons', false
    atom.config.set 'file-icon-supplement.grammarStatusIcons', false
    atom.config.set 'file-icon-supplement.grammarSelectorIcons', false

  reloadStyleSheets: ->
    atom.themes.reloadBaseStylesheets()
