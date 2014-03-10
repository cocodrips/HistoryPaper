window.onload = ()->
  plain_text = document.documentElement.innerText
  registKeywords(plain_text)


registKeywords = (plain_text)->
  console.log "-----------きてる-------"
  content = new Content(plain_text)
  console.log "content", content
  console.log content.keywords

#  if !hasContent(location.href)
#    setContent(location.href, plain_text)



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



  #  ex = new ExtractContents()
  #  ex.extractContents()
#  chrome.extension.sendRequest({storage: location.href, value: plain_text})
#  chrome.extension.sendRequest({storage: location.href}, (response) ->
#    console.log 'foo => ' + response
