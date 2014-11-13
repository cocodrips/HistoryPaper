@searchWordList = (hashmap)->
  titles = []
  hashmap.forEach(
    (page)=>
      if page.url.indexOf("https://www.google.co.jp/") != -1
        q = getGroup(decodeURI(page.url), /#q=(.*)\&/, 1)
        if not q
          q = getGroup(decodeURI(page.url), /#q=(.*)/, 1)

        if q
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
  keywords.sort((a, b)-> if a['times'] < b['times'] then 1 else -1)
  drawWordList(keywords)
  return keywords

getGroup = (content, re, groupNum) ->
  m = content.match(re)
  if m and m.length >= groupNum
    return m[groupNum]
  return ""

drawWordList = (sorted)->
  keywordsHtml = ""
  count = 0
  for s of sorted
    if count++ < 50
      keywordsHtml += "<span style='font-size:" + (12 + Math.min(sorted[s].times * 2, 20)) + "px;'><pre>" + sorted[s].keyword + "</pre></span>"
  $('#key-cloud').text("")
  $('#key-cloud').append(keywordsHtml)