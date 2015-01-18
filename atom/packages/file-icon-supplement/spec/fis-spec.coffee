{WorkspaceView} = require 'atom'
path = require 'path'
wrench = require 'wrench'
fs = require 'fs-plus'
temp = require('temp').track()

describe "Test Suite", ->
  it "has some expectations that should pass", ->
    expect(true).toBe true
    expect("apples").toEqual "apples"
    expect("oranges").not.toEqual "apples"

describe 'activation', ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    waitsForPromise ->
      atom.packages.activatePackage 'status-bar'

    runs ->
      activationPromise = atom.packages.activatePackage 'file-icon-supplement'

  it 'it is disabled by default', ->
    expect(activationPromise.isFulfilled()).not.toBeTruthy()
    expect(atom.packages.isPackageActive 'file-icon-supplement').toBe false

  it 'it enables with event', ->
    atom.workspaceView.trigger 'editor:display-updated'

    waitsForPromise ->
      activationPromise

    runs ->
      expect(atom.packages.isPackageActive 'file-icon-supplement').toBe true

describe 'file-icon-supplement base-ui', ->

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    waitsForPromise ->
      atom.packages.activatePackage 'tabs'
    waitsForPromise ->
      atom.packages.activatePackage 'tree-view'
    waitsForPromise ->
      atom.packages.activatePackage 'status-bar'
    waitsForPromise ->
      atom.packages.activatePackage 'grammar-selector'
    waitsForPromise ->
      atom.workspace.open()

  it 'it automatically adds base-ui classes on open', ->
    waitsForPromise ->
      atom.packages.activatePackage 'file-icon-supplement'

    atom.packages.emit 'activated'

    runs ->
      expect(atom.workspaceView.find '.fis-tab').toExist()
      expect(atom.workspaceView.find '.fis-tree').toExist()
      expect(atom.workspaceView.find '.fis-grammar-status').toExist()

  it 'it adds only the classes that are specificed in the config on open', ->
    atom.config.set 'file-icon-supplement.treeViewIcons', false
    atom.config.set 'file-icon-supplement.tabIcons', false
    atom.config.set 'file-icon-supplement.grammarStatusIcons', false

    waitsForPromise ->
      atom.packages.activatePackage 'file-icon-supplement'

    atom.packages.emit 'activated'

    runs ->
      expect(atom.workspaceView.find '.fis-tree').not.toExist()
      expect(atom.workspaceView.find '.fis-tab').not.toExist()
      expect(atom.workspaceView.find '.fis-grammar-status').not.toExist()

  it 'it responds to changes in the config after open', ->
    waitsForPromise ->
      atom.packages.activatePackage 'file-icon-supplement'

    atom.packages.emit 'activated'

    runs ->
      expect(atom.workspaceView.find '.fis-tree').toExist()
      expect(atom.workspaceView.find '.fis-tab').toExist()
      expect(atom.workspaceView.find '.fis-grammar-status').toExist()

      atom.config.set 'file-icon-supplement.treeViewIcons', false
      atom.config.set 'file-icon-supplement.tabIcons', false
      atom.config.set 'file-icon-supplement.grammarStatusIcons', false

      expect(atom.workspaceView.find '.fis-tree').not.toExist()
      expect(atom.workspaceView.find '.fis-tab').not.toExist()
      expect(atom.workspaceView.find '.fis-grammar-status').not.toExist()

describe 'file-icon-supplement', ->
  beforeEach ->
    atom.project.setPath path.join __dirname, 'fixtures'
    tempPath = fs.realpathSync temp.mkdirSync 'atom'
    fixturesPath = atom.project.getPath()
    wrench.copyDirSyncRecursive fixturesPath, tempPath, forceDelete: true
    atom.project.setPath path.join tempPath, 'file-icon-supplement'

    atom.workspaceView = new WorkspaceView
    waitsForPromise ->
      atom.packages.activatePackage 'tabs'
    waitsForPromise ->
      atom.packages.activatePackage 'tree-view'
    waitsForPromise ->
      atom.packages.activatePackage 'fuzzy-finder'
    waitsForPromise ->
      atom.packages.activatePackage 'status-bar'
    waitsForPromise ->
      atom.packages.activatePackage 'grammar-selector'
    waitsForPromise ->
      atom.workspace.open 'example.js'
    waitsForPromise ->
      atom.packages.activatePackage 'file-icon-supplement'
    runs ->
      atom.packages.emit 'activated'

  describe 'toggles', ->

    describe 'file-icon-supplement:toggleTreeViewClass', ->
      it 'it can trigger a tree-view toggle', ->
        atom.workspaceView.trigger 'file-icon-supplement:toggleTreeViewClass'
        expect(atom.workspaceView.find '.fis-tree').not.toExist()
        expect(atom.workspaceView.find '.fis-tab').toExist()
        expect(atom.workspaceView.find '.fis-grammar-status').toExist()
        atom.workspaceView.trigger 'file-icon-supplement:toggleTreeViewClass'
        expect(atom.workspaceView.find '.fis-tree').toExist()
        expect(atom.workspaceView.find '.fis-tab').toExist()
        expect(atom.workspaceView.find '.fis-grammar-status').toExist()

    describe 'file-icon-supplement:toggleTabClass', ->
      it 'it can trigger a tab toggle', ->
        atom.workspaceView.trigger 'file-icon-supplement:toggleTabClass'
        expect(atom.workspaceView.find '.fis-tree').toExist()
        expect(atom.workspaceView.find '.fis-tab').not.toExist()
        expect(atom.workspaceView.find '.fis-grammar-status').toExist()
        atom.workspaceView.trigger 'file-icon-supplement:toggleTabClass'
        expect(atom.workspaceView.find '.fis-tree').toExist()
        expect(atom.workspaceView.find '.fis-tab').toExist()
        expect(atom.workspaceView.find '.fis-grammar-status').toExist()

    describe 'file-icon-supplement:toggleGrammarStatusClass', ->
      it 'it can trigger a grammar status toggle', ->
        atom.workspaceView.trigger 'file-icon-supplement:toggleGrammarStatusClass'
        expect(atom.workspaceView.find '.fis-tree').toExist()
        expect(atom.workspaceView.find '.fis-tab').toExist()
        expect(atom.workspaceView.find '.fis-grammar-status').not.toExist()
        atom.workspaceView.trigger 'file-icon-supplement:toggleGrammarStatusClass'
        expect(atom.workspaceView.find '.fis-tree').toExist()
        expect(atom.workspaceView.find '.fis-tab').toExist()
        expect(atom.workspaceView.find '.fis-grammar-status').toExist()

    describe 'file-icon-supplement:toggleFuzzyFinderClass', ->
      it 'it can trigger a fuzzy-finder toggle', ->
        atom.workspaceView.trigger 'fuzzy-finder:toggle-file-finder'
        atom.workspaceView.trigger 'file-icon-supplement:toggleFuzzyFinderClass'
        expect(atom.workspaceView.find '.fis-fuzzy').not.toExist()
        atom.workspaceView.trigger 'file-icon-supplement:toggleFuzzyFinderClass'
        expect(atom.workspaceView.find '.fis-fuzzy').toExist()

    describe 'file-icon-supplement:toggleAllClass', ->
      it 'it toggles all off on first trigger', ->
        expect(atom.workspaceView.find '.fis-tree').toExist()
        expect(atom.workspaceView.find '.fis-tab').toExist()
        expect(atom.workspaceView.find '.fis-grammar-status').toExist()
        atom.workspaceView.trigger 'file-icon-supplement:toggleAllClass'
        expect(atom.workspaceView.find '.fis-tree').not.toExist()
        expect(atom.workspaceView.find '.fis-tab').not.toExist()
        expect(atom.workspaceView.find '.fis-grammar-status').not.toExist()
        atom.workspaceView.trigger 'file-icon-supplement:toggleAllClass'
        expect(atom.workspaceView.find '.fis-tree').toExist()
        expect(atom.workspaceView.find '.fis-tab').toExist()
        expect(atom.workspaceView.find '.fis-grammar-status').toExist()

      it 'it only enables previously enabled areas on second trigger', ->
        atom.workspaceView.trigger 'file-icon-supplement:toggleTabClass'
        atom.workspaceView.trigger 'file-icon-supplement:toggleAllClass'
        atom.workspaceView.trigger 'file-icon-supplement:toggleAllClass'
        expect(atom.workspaceView.find '.fis-tree').toExist()
        expect(atom.workspaceView.find '.fis-tab').not.toExist()
        expect(atom.workspaceView.find '.fis-grammar-status').toExist()
        expect(Object.keys(atom.config.get 'file-icon-supplement').length)
          .toBe 6

  describe 'grammar-selector', ->
    it 'it adds the grammar selector class when triggered', ->
      expect(atom.workspaceView.find '.grammar-selector').not.toExist()
      expect(atom.workspaceView.find '.fis-grammar-selector').not.toExist()
      atom.workspaceView.trigger 'grammar-selector:show'
      expect(atom.workspaceView.find '.grammar-selector').toExist()
      expect(atom.workspaceView.find '.fis-grammar-selector').toExist()

  describe 'fuzzy-finder', ->
    it 'it adds the fuzzy class when triggered', ->
      expect(atom.workspaceView.find '.fuzzy-finder').not.toExist()
      expect(atom.workspaceView.find '.fis-fuzzy').not.toExist()
      atom.workspaceView.trigger 'fuzzy-finder:toggle-file-finder'
      expect(atom.workspaceView.find '.fuzzy-finder').toExist()
      expect(atom.workspaceView.find '.fis-fuzzy').toExist()
