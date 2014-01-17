window.onload = ()->
#  plain_text = document.documentElement.innerText
#  console.log plain_text
  if !hasContent("s")
    setContent("a", "Hello")


hasContent = (url)->
  chrome.storage.local.get [url], (items) ->
    if chrome.extension.lastError isnt undefined
      return false
    else
      console.log "------------historypaper", items
      return true
#      console.log(items.value);

setContent = (url, content)->
  data = {"a": [content, new Date()]}
  chrome.storage.local.set data, () ->
    if chrome.extension.lastError isnt undefined
      return false
    else
      return true


