class @HistoryObject
  constructor: ()->
    @title = ""
    @content = "Hello, World!"
    @rect = {}

    @imageurl = ""
    @imageaspect = 0
    @priority = 10

class @Rect
  constructor: (@left, @top, @width, @height)->
