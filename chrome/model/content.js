// Generated by CoffeeScript 1.6.3
(function() {
  var registPlainText;

  window.onload = function() {
    var plain_text;
    plain_text = document.documentElement.innerText;
    return registPlainText(plain_text);
  };

  registPlainText = function(plain_text) {
    return chrome.extension.sendRequest({
      storage: location.href,
      value: plain_text
    });
  };

}).call(this);
