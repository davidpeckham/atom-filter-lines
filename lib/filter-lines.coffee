FilterLinesView = require './filter-lines-view'
{CompositeDisposable} = require 'atom'

module.exports = FilterLines =
  filterLinesView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @filterLinesView = new FilterLinesView(state.filterLinesViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @filterLinesView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'filter-lines:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @filterLinesView.destroy()

  serialize: ->
    filterLinesViewState: @filterLinesView.serialize()

  toggle: ->
    console.log 'FilterLines was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
