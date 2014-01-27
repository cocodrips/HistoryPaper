class @Layout
  constructor: ()->
    @aspect = 1.3
    @clusterNum = 15
    @squareSize = 0
    @rows = 0
    @cols = 0

  createLayout: ()->
    w = window.innerWidth
    h = window.innerHeight
    @calcSquareSize(w, h)
    data = @calcPosition(w)
    @arrangeArticles(data)

  calcSquareSize: (width, height)->
    rectangleWidth = width / @aspect
    squareSize = height
    cols = 0
    rows = 1
    while cols * rows < @clusterNum
      cols++
      squareSize = height / cols
      rows = Math.round(rectangleWidth / squareSize)
    @cols = cols
    @rows = rows
    @squareSize = squareSize

  calcPosition:(w) ->
    historyObjects = []
    articleWidth = @squareSize * (w / (@squareSize * @cols))
    articleHeight = @squareSize
    for c in [0...@cols]
      for r in [0...@rows]
        obj = new HistoryObject()
        obj.left = r * articleWidth
        obj.top = c * articleHeight
        obj.width = articleWidth
        obj.height = articleHeight
        historyObjects[(c * @rows) + r] = obj
    return historyObjects

  arrangeArticles: (data)->
    d3.select("#main-container")
      .selectAll("article")
      .data(data)
      .enter()
      .append("article")
      .attr("class", "article")
      .style("width", (d)-> return d.width + "px")
      .style("height", (d)-> return d.height + "px")
      .style("top", (d)-> return d.top + "px")
      .style("left", (d)-> return d.left + "px")
      .text("object")








