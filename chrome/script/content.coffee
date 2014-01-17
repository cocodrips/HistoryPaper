window.onload = ()->
  plain_text = document.documentElement.innerText
  console.log plain_text


hasContent = (url, content)->
  chrome.storage.local.get keys, (items) ->
    if chrome.extension.lastError isnt undefined
      return false
    else
      return true
#      console.log(items.value);

setContent = (url, content)->
  data = {url: [content, new Date()]}
  chrome.storage.local.set data, () ->
    if chrome.extension.lastError isnt undefined
      return false
    else
      return true


