class @Layout
  constructor: (@histories)->
    @aspect = 1.3
    @clusterNum = if histories then histories.length else 0
    @squareSize = 0
    @rows = 0
    @cols = 0

  drawArticles: ()->
    w = window.innerWidth
    h = window.innerHeight
    @calcSquareSize(w, h)
    @setPositionInfo2Histories(w)
    console.log @histories
    @arrangeArticles(@histories)

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

  setPositionInfo2Histories:(w) ->
    articleWidth = @squareSize * (w / (@squareSize * @cols))
    articleHeight = @squareSize
    for c in [0...@cols]
      for r in [0...@rows]
        obj = @histories[(c * @rows) + r]
        if obj
          obj.left = r * articleWidth
          obj.top = c * articleHeight
          obj.width = articleWidth
          obj.height = articleHeight

  arrangeArticles: (histories)->
    d3.select("#main-container")
      .selectAll("article")
      .data(histories)
      .enter()
      .append("article")
      .attr("class", "article")
      .style("width", (d)-> return d.width + "px")
      .style("height", (d)-> return d.height + "px")
      .style("top", (d)-> return d.top + "px")
      .style("left", (d)-> return d.left + "px")
      .text((d)-> return d.title)








