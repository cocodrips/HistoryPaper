class @HistoryObject
  constructor: (data)->
    @title = data['title']
    @content = data['content']
    @imageurl = data['image_url']
    @imageaspect = 0
    @url = data['url']
    @priority = data['priority']
    @rect = new Rect(data['rect'][0], data['rect'][1], data['rect'][2], data['rect'][3])
    @urls = data['urls']
    @titles = data['titles']
    @categories = data['categories']