// Generated by CoffeeScript 1.6.3
(function() {
  var hasContent, setContent;

  window.onload = function() {
    if (!hasContent("s")) {
      return setContent("a", "Hello");
    }
  };

  hasContent = function(url) {
    return chrome.storage.local.get([url], function(items) {
      if (chrome.extension.lastError !== void 0) {
        return false;
      } else {
        console.log("------------historypaper", items);
        return true;
      }
    });
  };

  setContent = function(url, content) {
    var data;
    data = {
      "a": [content, new Date()]
    };
    return chrome.storage.local.set(data, function() {
      if (chrome.extension.lastError !== void 0) {
        return false;
      } else {
        return true;
      }
    });
  };

}).call(this);
