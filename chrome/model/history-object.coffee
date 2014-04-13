class @HistoryObject
  constructor: ()->
    @title = ""
    @content = "Hello, World!"
    @rect = {}

    @imageurl = ""
    @imageaspect = 0
    @priority

class Rect
  contructor: (@left, @top, @width, @height)->
