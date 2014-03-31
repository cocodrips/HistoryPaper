window.onload = ()->
  re = /^https/i
  if location.href.match(re)
    plain_text = document.documentElement.innerText
  registPlainText(plain_text)

registPlainText = (plain_text)->
  chrome.extension.sendRequest({storage: location.href, value: plain_text})
