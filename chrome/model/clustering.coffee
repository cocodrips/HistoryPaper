class @Clustering
  constructor:(histories)->
    @searchWords=[]
    @histories = new CreateHistoryObject(histories)
    clusterNum = @calcClusterNum()
    @clusters = []
    for i in [0...clusterNum]
      @clusters[i] = []

  clusteringHistories:()->
    @setWords2Histories()
    @setKeys2Histories()
    kmeans = new Kmeans(@histories, @clusters.length)
    objs = kmeans.start()
    for obj, i in objs
      @clusters[obj.clusterId].push(i)

  #TODO: naming
  getClusterHistories: (clusterId)->
    histories = []
    for i in [0...@clusters[clusterId].length]
      histories[i] = @histories[@clusters[clusterId][i]]
    return histories

  # set keyword as coordinate
  setKeys2Histories: () ->
    topKeywords = @selectTopKeywords(100)
    # TODO: Improve the algorithm
    for history in @histories
      keywords = {}
      for k in topKeywords
        if _.contains(history.words, k)
          if keywords[k]
            keywords[k]++
          else
            keywords[k] = 1
        else
          keywords[k] = 0
      history.coordinate = keywords

  setWords2Histories: ()->
    for history in @histories
      segmenter = new TinySegmenter()
      history.words = segmenter.segment(history.title)

  calcClusterNum: ()->
    return 9
#    return Math.min(@histories.length, 20)


  registSearchWord: (history)->
    q = history.url.match /\?q=.*?\&/
    if !q
      return
    try
      q = decodeURI(q[0]).replace(/\?q=(.*?)\&/,'$1')
      q = q.split /[\s,\+]+/
      for query in q
        if @searchWords[query] then @searchWords[query]++ else  @searchWords[query]=1

  selectTopKeywords: (n)->
    data = []
    for history in @histories
      for word in history.words
        word = $.trim(word)
        if data[word] then data[word]++ else data[word] = 1

    keywords = Utils.sortByValue(data, true)
    topKeywords = []
    i = 0
    for keyword in keywords
      if !stopwords[keyword]
        topKeywords.push(keyword)
        if ++i >= n
          break
    return topKeywords

  extractKeyword:(history) ->
    keywords = []
    for word in history.words
      if Utils.isKeyword(word) then keywords.push(word)




class CreateHistoryObject
  constructor:(histories)->
    return @createHistoryObject(histories)

  createHistoryObject: (histories)->
    histories = @exceptHistories(histories)
    console.log histories
    urls = []
    historyObjs = []
    for history in histories
#      if _.contains(urls, history.url)
#        console.log 'already contain'
#        continue
#      urls.push(history.url)

      obj = new HistoryObject()
      for k, v of history
        obj[k] = v
      historyObjs.push(obj)
    return historyObjs

  exceptHistories: (histories)->
    h = []
    for history in histories
      if @canSelect(history)
        h.push(history)
    return h

  canSelect: (history)->
    conditions = {
      isNotSearch: (history)->
        if history.url.indexOf("https://www.google.co.jp/search?") > -1
          return false
        return true

      isNotBinary: (history)->
        pageType = history.url.split("/").pop()
        target = ["png", "jpg", "mp3"]
        for t in target
          if pageType.indexOf(t) != -1
            return false
        return true
    }
    for k, v of conditions
      if !v(history)
        return false
    return true


