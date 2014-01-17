class @Clustering
  constructor:(histories)->
    @histories = histories

  addKeys2Histories: () ->
    @extractKeyword(history.title) for history in @histories

  extractKeyword:(title) ->
    segmenter = new TinySegmenter()
    words = segmenter.segment(title)
    keywords = []
    for word in words
      if isKeyword(word) then keywords.append(word)
    console.log keywords

  isKeyword: (word) ->
    if word.length == 1
      return false
    if stopwords[word]
      return false
    return true
#    pattern = []
#    pattern.push(patternType(c)) for c in word.split("")

  patternType:(c) ->
    patterns = {
      "[一二三四五六七八九十百千万億兆]":"M",
      "[一-龠々〆ヵヶ]":"H",
      "[ぁ-ん]":"I",
      "[ァ-ヴーｱ-ﾝﾞｰ]":"K",
      "[a-zA-Zａ-ｚＡ-Ｚ]":"A",
      "[0-9０-９]":"N"
    }

    for key in Object.keys(patterns)
      re = new RegExp(key)
      return patterns[key] if c.match(re)
