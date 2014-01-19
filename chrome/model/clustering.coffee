class @Clustering
  constructor:(histories)->
    @histories = histories

  addKeys2Histories: () ->
    @extractKeyword(history) for history in @histories


  selectTopKeywords: (n)->
    data = []
    for history in @histories
      segmenter = new TinySegmenter()
      words = segmenter.segment(history.title)
      for word in words
        word = $.trim(word)
        if data[word]
          data[word]++
        else
          data[word] = 1

    keywords = @sortByValue(data, true)

    topkeywords = []
    i = 0
    for keyword in keywords
      if !stopwords[keyword]
        topkeywords.push(keyword)
        if ++i >= n
          break
    return topkeywords



  extractKeyword:(history) ->
    segmenter = new TinySegmenter()
    words = segmenter.segment(history.title)
    keywords = []
    for word in words
      if @isKeyword(word) then keywords.push(word)
    console.log @histories

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




