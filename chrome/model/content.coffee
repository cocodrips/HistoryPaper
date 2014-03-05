window.onload = ()->
  plain_text = document.documentElement.innerText
  console.log plain_text

#  ex = new ExtractContents()
#  ex.extractContents()
  chrome.extension.sendRequest({storage: location.href, value: plain_text})
  chrome.extension.sendRequest({storage: location.href}, (response) ->
    console.log 'foo => ' + response
  )

#  if !hasContent(location.href)
#    setContent(location.href, plain_text)

class Node
  constructor: (@score, @content)->
    @strlen = @content.length

class ExtractContents
  extractContents: ()->
    nodes = @extractNodes()
    console.log @selectContent(nodes)

  extractNodes: ()->
    # Add other element
    targets = ["div"]
    nodes = []
    i = 0
    for target in targets
      elements = document.getElementsByTagName(target)
      for element in elements
        node = new Node(@scoreringNode(element), element.innerText)
        nodes[i] = node
        i++
    return nodes

  scoreringNode: (element)->
    return @countPunctuation(element.innerText)

  countPunctuation: (str)->
    target = "。|、"
    re = new RegExp(target)
    cnt = 0
    for c in str
      if c.match(re)
        cnt++
    return cnt


  selectContent: (nodes)->
    nodes.sort (a, b) =>
      aScore = Math.sqrt(a.score) / a.strlen
      bScore = Math.sqrt(b.score) / b.strlen
      return -1 if aScore < bScore
      return 1 if aScore > bScore
      return 0
    console.log nodes
    return nodes[0]





#hasContent = (url)->
#  chrome.storage.local.get [url], (items) ->
#    if chrome.extension.lastError isnt undefined
#      return false
#    else
#      console.log "------------historypaper", items
#      return true
##      console.log(items.value);
#
#setContent = (url, content)->
#  data = {"a": [content, new Date()]}
#  chrome.storage.local.set data, () ->
#    if chrome.extension.lastError isnt undefined
#      return false
#    else
#      return true
#
#
#



