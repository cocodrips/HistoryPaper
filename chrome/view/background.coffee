chrome.extension.onRequest.addListener (request, sender, sendResponse)->
  console.log request
  if request.storage
    if typeof request.value != 'undefined'
      localStorage[request.strage] = request.value
    sendResponse({storage: localStorage[request.storage]})
  else
    sendResponse({})