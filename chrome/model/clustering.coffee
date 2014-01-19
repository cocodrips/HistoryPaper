class @Clustering
  constructor:(histories)->
    @searchWords=null
    @histories = @removeSearchHistory(histories)
    @setWords2Histories()
    @setKeys2Histories()


  clustering:()->
    console.log "a"


  setKeys2Histories: () ->
    topKeywords = @selectTopKeywords(100)
    for history in @histories
      keywords = []
      for word in history.words
        if _.contains(topKeywords, word)
          keywords.push(word)
      history.keywords = keywords
    console.log @histories

  setWords2Histories: ()->
    for history in @histories
      segmenter = new TinySegmenter()
      history.words = segmenter.segment(history.title)

  removeSearchHistory: (histories)->
    words = {}
    h = []
    for history in histories
      if history.url.indexOf("https://www.google.co.jp/search?") == -1
        h.push(history)
      q = history.url.match /\?q=.*?\&/
      if !q
        continue
      try
        q = decodeURI(q[0]).replace(/\?q=(.*?)\&/,'$1')
        q = q.split /[\s,\+]+/
        for query in q
          if !words[query]
            words[query] = 1
          else
            words[query] += 1
    @searchWords = words
    return h

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




