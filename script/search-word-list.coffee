@searchWordList = (hashmap)->
  titles = []
  hashmap.forEach(
    (page)=>
      if page.url.indexOf("https://www.google.co.jp/search?") != -1
        q = page.url.match /\?q=.*?\&/
        if q
          q = decodeURI q[0].replace /\?q=(.*?)\&/,'$1'
          q = q.split /[\s,\+]+/
          q.forEach(
            (title)=>
              if !titles[title]
                titles[title] = 1
              else
                titles[title] += 1
          )
  )
  keywords = []
  for i of titles
    keywords.push({
      'keyword' : i,
      'times' : titles[i]
    })
  drawWordList(sortedWordListByTimes(keywords))

drawWordList = (sorted)->
  keywordsHtml = ""
  count = 0
  for s of sorted
    if count++ < 50
      keywordsHtml += "<span style='font-size:" + (8 + Math.min(sorted[s].times, 20)) + "px;'><pre>" + sorted[s].keyword + "</pre></span>"
  $('#key-cloud').text("")
  $('#key-cloud').append(keywordsHtml)
