class @Cluster
  constructor:(histories)->
    @histories = histories

  addKeys2History: () ->
    extractKeyword(history.title) for history in @histories

  extractKeyword = (title) ->
    segmenter = new TinySegmenter()
    words = segmenter.segment(title)
    console.log words
    isKeyword(word) for word in words

  isKeyword = (word) ->
    pattern = []
    pattern.push(patternType(c)) for c in word.split("")


  patternType = (c) ->
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



