// Generated by CoffeeScript 1.6.3
(function() {
  var drawWordList;

  this.searchWordList = function(hashmap) {
    var i, keywords, titles,
      _this = this;
    titles = [];
    hashmap.forEach(function(page) {
      var q;
      if (page.url.indexOf("https://www.google.co.jp/") !== -1) {
        q = page.url.match(/#q=.*\&?/);
        if (q) {
          q = decodeURI(q[0].replace(/#q=(.*?)\&?/, '$1'));
          q = q.split(/[\s,\+]+/);
          return q.forEach(function(title) {
            if (!titles[title]) {
              return titles[title] = 1;
            } else {
              return titles[title] += 1;
            }
          });
        }
      }
    });
    keywords = [];
    for (i in titles) {
      keywords.push({
        'keyword': i,
        'times': titles[i]
      });
    }
    keywords.sort(function(a, b) {
      if (a['times'] < b['times']) {
        return 1;
      } else {
        return -1;
      }
    });
    return drawWordList(keywords);
  };

  drawWordList = function(sorted) {
    var count, keywordsHtml, s;
    keywordsHtml = "";
    count = 0;
    for (s in sorted) {
      if (count++ < 50) {
        keywordsHtml += "<span style='font-size:" + (8 + Math.min(sorted[s].times, 20)) + "px;'><pre>" + sorted[s].keyword + "</pre></span>";
      }
    }
    $('#key-cloud').text("");
    return $('#key-cloud').append(keywordsHtml);
  };

}).call(this);
