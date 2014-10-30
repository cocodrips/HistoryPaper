window.Utils = {
  sortByValue:(data, reverse)->
    z = []
    for k,v of data
      z.push([v, k])

    z.sort (a, b)->
      if a[0] < b[0]
        return -1
      if a[0] > b[0]
        return 1
      return 0

    if reverse
      z.reverse()
    l = []
    l.push(e[1]) for e in z
    return l
  ,
  isKeyword: (word) ->
    if word.length == 1
      return false
    if stopwords[word]
      return false
    return true
  ,
  extractContents: (url)->
    $.get url, (data) ->
      return data
    return ''
  ,
}
