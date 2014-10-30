
class @Layout
  constructor: (@histories)->
    @aspect = 1.4
    @clusterNum = if histories then histories.length else 0
    @squareSize = 0
    @rows = 0
    @cols = 0
    @title_only = 60

  drawArticles: ()->
    w = window.innerWidth - (40 + 300)
    h = window.innerHeight - 100
    $("#container").css("height", h + "px")

#    @calcSquareSize(w, h)
#    @setPositionInfo2Histories(w)
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
    articleHeight = @squareSize
    articleWidth = @squareSize * @aspect
#    console.log @squareSize
    #    articleWidth = @squareSize * (w / (@squareSize * @cols))
    for c in [0...@cols]
      for r in [0...@rows]
        obj = @histories[(c * @rows) + r]
        if obj
          obj.left = r * articleWidth
          obj.top = c * articleHeight
          obj.width = articleWidth
          obj.height = articleHeight
    @histories[1]

  arrangeArticles: (histories)->
#    console.log histories
    articles = d3.select("#main-container")
      .selectAll("article")
      .data(histories)
      .enter()
      .append("article")
      .attr("class", "article")
      .style("width", (d)-> return d.rect.width + "px")
      .style("height", (d)-> return d.rect.height + "px")
      .style("top", (d)-> return d.rect.top + "px")
      .style("left", (d)-> return d.rect.left + "px")
      .append("div")
      .attr("class", "article-inner")

    articles.append("a")
    .attr("href", (d) -> return d.url)
    .attr("target", "_blank")
    .append("h2")
      .text((d)-> return d.title)
      .style("font-size", (d)->
        if d.rect.width > 200
          return "140%"
        else
          return "120%"
      )
      .style("max-height", (d)-> return if d.rect.height < @title_only then "1.5em" else "3.0em")


    articles.append("a")
      .attr("href", (d) -> return d.url)
      .attr("target", "_blank")
      .append("div")
      .attr("class", "url")
      .text((d) -> return if d.rect.height < @title_only then "" else d.url)

    images = articles
      .append("div")
      .attr("class", "image_box")
      .style("max-width", (d)->
        return if d.rect.width < d.rect.height * 1.6 then "100%" else "50%")
      .style("text-align", (d)->
        return if d.rect.width < d.rect.height * 1.6 then "center" else "center")
      .append("img")
      .attr("src", (d) ->
        console.log d.imageurl
        return d.imageurl)
      .style("float", (d)->
        return if d.rect.width < d.rect.height * 1.6 then "none" else "left")
      .style("max-width", (d)-> return "100%")
      .style("max-height", (d)->
        return if d.rect.width < d.rect.height * 1.6 then "50%" else "70%")


    content_header_height = 150

    articles.append("div")
      .attr("class", "content")
      .text((d) ->
        return d.content
      )
#      .style("height", (d)->
#        return Math.max(d.rect.height - content_header_height, 0) + "px")


    $('img').remove()
  loaded: (is_success) ->
    $('.loading').css('display', 'none')









