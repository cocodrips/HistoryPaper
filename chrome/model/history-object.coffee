class @HistoryObject
  constructor: (data)->
    @title = data['title']
    @content = data['content']
    @rect = Rect(data['rect'])
    @imageurl = ""
    @imageaspect = 0
    @url = data['url']
    @priority = data['priority']

class @Rect
  constructor: (vector4)->
    @left = vector4[0]
    @top = vector4[1]
    @width = vector4[2]
    @height = vector4[3]

