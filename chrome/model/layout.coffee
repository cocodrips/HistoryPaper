
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
    @arrangeArticles(@histories)

  setRect:(width, height)->
    data = []
    for history in @histories
      data.push(new Page(history.priority, "text", history.title))
    layout = new GreedyLayout(null, data, width, height, 400, 400)
    layout.layout()
    for i in [0...@histories.length]
      @histories[i].rect = layout.pageSets[i].rect
    console.log "history", @histories

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
      .style("top", (d)-> return d.rect.y + "px")
      .style("left", (d)-> return d.rect.x + "px")
      .append("div")
      .attr("class", "article-inner")

    articles.append("a")
    .attr("href", (d) -> return d.url)
    .attr("target", "_blank")
    .append("h2")
      .text((d)-> return d.title)
      .style("font-size", (d)->
        if d.rect.width > 200
          return "1.1em"
        else
          return "1em"
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


    $('img').remove()


  loaded: (is_success) ->
    if is_success
      $('.loading').css('display', 'none')
    else
      $('.loading').css('display', 'none')
      $('.ajax-fail').css('display', 'block')


  no_data: () ->
    $('.loading').css('display', 'none')
    $('.ajax-fail').css('display', 'block')









