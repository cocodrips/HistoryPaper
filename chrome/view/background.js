// Generated by CoffeeScript 1.6.3
(function() {
  chrome.extension.onRequest.addListener(function(request, sender, sendResponse) {
    var items;
    if (request['storage']) {
      items = {};
      items[request['storage']] = request['value'];
      return chrome.storage.local.set(items, function() {
        return console.log("registed");
      });
    }
  });

}).call(this);
