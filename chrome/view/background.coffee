

chrome.extension.onRequest.addListener (request, sender, sendResponse)->
  if request['storage']
    items = {}
    items[request['storage']] = request['value']
    chrome.storage.local.set items, () ->
      console.log "registed", items

