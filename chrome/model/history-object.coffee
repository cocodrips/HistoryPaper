class @HistoryObject
  constructor: (data)->
    @title = data['title']
    @content = data['content']
    @imageurl = data['image_url']
    @imageaspect = 0
    @url = data['url']
    @priority = data['priority']
    @rect = null