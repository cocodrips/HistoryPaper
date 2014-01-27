class @Layout
#  constructor: ()->

  createLayout: ()->
    w = screen.availWidth
    h = screen.availHeight
    data = @calcPosition(w, h, 5, 5)
    @arrangeArticles(data)

  calcPosition:(width, height, row, col) ->
    historyObjects = []
    aw = width / row
    ah = height / col
    for c in [0...col]
      for r in [0...row]
        obj = new HistoryObject()
        obj.left = r * aw
        obj.top = c * ah
        obj.width = aw
        obj.height = ah
        historyObjects[(c * row) + r] = obj
    console.log historyObjects

    arrangeArticles: (data)->
#      d3.select("")
      console.log "layout"








