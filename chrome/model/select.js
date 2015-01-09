// Generated by CoffeeScript 1.6.3
(function() {
  var histories;

  histories = [];

  $(function() {
    return $('#submit').on('click', function(e) {
      var content, history, keyword, o, post_data, selected, title, unselected, visit, _i, _len;
      selected = [];
      unselected = [];
      histories = $('.article .article-inner');
      for (_i = 0, _len = histories.length; _i < _len; _i++) {
        history = histories[_i];
        visit = history.children[0].getAttribute('data-visit');
        keyword = history.children[0].getAttribute('data-keyword');
        title = history.children[1].innerHTML;
        content = history.children[0].getAttribute('data-content');
        o = {
          "visit": visit,
          "keyword": keyword,
          "title": title,
          "content": content
        };
        if (history.className.indexOf('selected') < 0) {
          unselected.push(o);
        } else {
          selected.push(o);
        }
      }
      post_data = {
        "selected": selected,
        "unselected": unselected
      };
      return $.ajax({
        type: 'post',
        url: 'http://192.168.113.2:5000/history/selected/',
        data: JSON.stringify(post_data),
        dataType: 'json',
        contentType: 'application/json',
        success: function(response) {
          return alert("success");
        },
        error: function(xhr, type) {
          return console.log('AjaxError:', xhr, type);
        }
      });
    });
  });

  this.History = (function() {
    function History() {}

    History.prototype.changeDate = function(date, cluster_num, tech_type, searchWord) {
      var end, layout, query, start,
        _this = this;
      if (searchWord == null) {
        searchWord = "";
      }
      start = Date.parse(date);
      end = Date.parse(date) + 86400000;
      query = {
        "text": searchWord,
        "startTime": start,
        "endTime": end,
        "maxResults": 1000
      };
      if (query.length <= 0) {
        layout = new Layout({});
        layout.no_data();
        return;
      }
      return chrome.history.search(query, function(array) {
        var a, keywords, post_data, urls, _i, _len;
        keywords = searchWordList(array);
        post_data = {};
        urls = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = array.length; _i < _len; _i++) {
            a = array[_i];
            _results.push(a['url']);
          }
          return _results;
        })();
        for (_i = 0, _len = array.length; _i < _len; _i++) {
          a = array[_i];
          if (a['url'].indexOf("http://") !== -1) {
            post_data[a['url']] = {
              'id': a['id'],
              'title': a['title'],
              'content': '',
              'url': a['url'],
              'visitCount': a['visitCount']
            };
          }
        }
        return chrome.storage.local.get(urls, (function(post_data, keywords, date, cluster_num, tech_type) {
          return function(items) {
            var data, key, value;
            for (key in items) {
              value = items[key];
              if (key.indexOf("https") === -1) {
                post_data[key]['content'] = value;
              }
            }
            console.log(post_data);
            post_data = (function() {
              var _j, _len1, _ref, _results;
              _ref = _.values(post_data);
              _results = [];
              for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
                data = _ref[_j];
                _results.push(data);
              }
              return _results;
            })();
            post_data = {
              'data': post_data,
              'date': date,
              'width': window.innerWidth - 380,
              'height': window.innerHeight - 150,
              600: 600,
              'keywords': keywords,
              'cluster_num': cluster_num,
              'tech_type': tech_type
            };
            console.log(post_data);
            return $.ajax({
              type: 'post',
              url: 'http://192.168.113.2:5000/history/select/',
              data: JSON.stringify(post_data),
              dataType: 'json',
              contentType: 'application/json',
              success: function(response) {
                var cluster, html, page, _j, _k, _len1, _len2;
                layout = new Layout({});
                layout.loaded(true);
                data = response;
                for (_j = 0, _len1 = data.length; _j < _len1; _j++) {
                  cluster = data[_j];
                  for (_k = 0, _len2 = cluster.length; _k < _len2; _k++) {
                    page = cluster[_k];
                    console.log(page.keyword_count, page);
                    html = '<div class="article" style="position:relative; width: 400px; height:400px; display: inline-block; vertical-align: top;">' + '<div class="article-inner">' + "<p data-keyword=\"" + page.keyword_count + "\" data-visit=\"" + page.visit_count + "\"data-content=\"" + page.content.length + "\" >" + '<h4>' + page.title + '</h4>' + '<div>' + page.content.slice(0, 501) + '</div>' + '</div>' + '</div>';
                    $('#main-container').append(html);
                  }
                }
                return $('.article-inner').on('click', function(e) {
                  $(this).toggleClass('selected');
                  return console.log(e);
                });
              },
              error: function(xhr, type) {
                layout = new Layout({});
                layout.loaded(false);
                return console.log('AjaxError:', xhr, type);
              }
            });
          };
        })(post_data, keywords, date, cluster_num, tech_type));
      });
    };

    return History;

  })();

}).call(this);
