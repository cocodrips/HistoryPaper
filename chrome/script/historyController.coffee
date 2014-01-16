$ ->
  now = new Date()
  changeDate(now)

  $('#date').on 'change', ->
    date = $('#date').val()
    console.log date
    if Date.parse(now) > Date.parse(date)
      changeDate(date)
    else
      console.log "We can't analyze your future."


changeDate = (date)->
  start = Date.parse(date) - 86400000;
  end = Date.parse(date);
  jsonData = ""

  chrome.history.search("text":"", "startTime":start, "endTime":end, "maxResults":10,
  (array)=>
#    hashmap = new Hashmap(array)
#    searchWordList(hashmap.hash)
#    jsonData = new CreateData(hashmap.sortedByTimes())
#    getJsonData.request(jsonData.urlList);
    cluster = new Cluster(array)
    cluster.addKeys2History()
  )



class Hashmap
  create_hash = (array) ->
    hash = []
    for e in array
      id = e.id
      if !hash[id]
        hash[id] = {
          time:e.visitCount
          url:e.url
          title:e.title
        }
    return hash

  sortedByTimes: ()->
    sorted =  _.sortBy(@hash, (e)=>
      return e.time
    )
    @hashSortedByTimes = sorted
    return @hashSortedByTimes


class CreateData
  constructor: (hash)->
    @urlList = createJson(hash)
    return @urlList

  createJson = (hash)->
    count = 0
    urls = ""
    json = {
      name: "json"
      children: []
    }
    hash.forEach (h) =>
      elementNum = calcElementNum()
      console.log elementNum
      if count < elementNum
        if canSelectPage(h)
          url = h.url.replace("http://","") + ","
          urls += url
          count++

    return urls

  calcElementNum = ()->
    width = $(window).width()
    height = $(window).height()
    s = width * height
    if s < 700000
      return 8
    else if s < 1500000
      return 10
    else
      return 12

  canSelectPage = (h)->
    if !@domainHash then @domainHash = []
    if h.url.indexOf("https") > -1
      return false

    if h.url.indexOf("http://") == -1
      return false

    if h.title.length < 2
      return false

    pageType = h.url.split("/").pop()
    target = ["png", "jpg", "mp3"]
    for t in target
      if pageType.indexOf(t) != -1
        return false

    domainType = h.url.split("/")[2]
    if !@domainHash[domainType]
      @domainHash[domainType] = true
    else
      return false

    exceptions = ["www.youtube.com", "127.0.0.1:5000", "localhost:8080"]
    for e in exceptions
      if domainType == e
        return false
    return true



