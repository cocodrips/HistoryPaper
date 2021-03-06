// Generated by CoffeeScript 1.6.3
(function() {
  window.Utils = {
    sortByValue: function(data, reverse) {
      var e, k, l, v, z, _i, _len;
      z = [];
      for (k in data) {
        v = data[k];
        z.push([v, k]);
      }
      z.sort(function(a, b) {
        if (a[0] < b[0]) {
          return -1;
        }
        if (a[0] > b[0]) {
          return 1;
        }
        return 0;
      });
      if (reverse) {
        z.reverse();
      }
      l = [];
      for (_i = 0, _len = z.length; _i < _len; _i++) {
        e = z[_i];
        l.push(e[1]);
      }
      return l;
    },
    isKeyword: function(word) {
      if (word.length === 1) {
        return false;
      }
      if (stopwords[word]) {
        return false;
      }
      return true;
    },
    extractContents: function(url) {
      $.get(url, function(data) {
        return data;
      });
      return '';
    }
  };

}).call(this);
