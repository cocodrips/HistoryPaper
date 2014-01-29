class @Clustering
  constructor:(histories)->
    @searchWords=[]
    @histories = @createHistoryObject(histories)
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

  # bad parts
  createHistoryObject: (histories)->
    histories = @exceptHistories(histories)
    historyObjs = []
    for history, i in histories
      obj = new HistoryObject()
      for k, v of history
        obj[k] = v
      historyObjs[i] = obj
    return historyObjs

  #TODO: naming
  getClusterHistories: (clusterId)->
    histories = []
    for i in [0...@clusters[clusterId].length]
      histories[i] = @histories[i]
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
    return Math.min(@histories.length, 20)

  exceptHistories: (histories)->
    h = []
    for history in histories
      if @canSelect(history)
        h.push(history)
    return h

  canSelect: (history)->
    if history.url.indexOf("https://www.google.co.jp/search?") > -1
      @registSearchWord(history)
      return false

    pageType = history.url.split("/").pop()
    target = ["png", "jpg", "mp3"]
    for t in target
      if pageType.indexOf(t) != -1
        return false
    return true

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

    keywords = @sortByValue(data, true)
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
      if @isKeyword(word) then keywords.push(word)

  isKeyword: (word) ->
    if word.length == 1
      return false
    if stopwords[word]
      return false
    return true

  sortByValue:(data, reverse)->
    z = []
    for k,v of data
      z.push([v, k])

    z.sort((a, b)->
      if a[0] < b[0]
        return -1
      if a[0] > b[0]
        return 1
      return 0
    )
    if reverse
      z.reverse()
    l = []
    l.push(e[1]) for e in z
    return l




