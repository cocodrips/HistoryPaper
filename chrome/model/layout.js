// Generated by CoffeeScript 1.6.3
(function() {
  this.Layout = (function() {
    function Layout(histories) {
      this.histories = histories;
      this.aspect = 1.4;
      this.clusterNum = histories ? histories.length : 0;
      this.squareSize = 0;
      this.rows = 0;
      this.cols = 0;
      this.title_only = 60;
    }

    Layout.prototype.drawArticles = function() {
      var h, w;
      w = window.innerWidth - (40 + 300);
      h = window.innerHeight - 100;
      $("#container").css("height", h + "px");
      return this.arrangeArticles(this.histories);
    };

    Layout.prototype.setRect = function(width, height) {
      var data, history, i, layout, _i, _j, _len, _ref, _ref1;
      data = [];
      _ref = this.histories;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        history = _ref[_i];
        data.push(new Page(history.priority, "text", history.title));
      }
      layout = new GreedyLayout(null, data, width, height, 400, 400);
      layout.layout();
      for (i = _j = 0, _ref1 = this.histories.length; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; i = 0 <= _ref1 ? ++_j : --_j) {
        this.histories[i].rect = layout.pageSets[i].rect;
      }
      return console.log("history", this.histories);
    };

    Layout.prototype.arrangeArticles = function(histories) {
      var articles, content_header_height, images;
      articles = d3.select("#main-container").selectAll("article").data(histories).enter().append("article").attr("class", "article").style("width", function(d) {
        return d.rect.width + "px";
      }).style("height", function(d) {
        return d.rect.height + "px";
      }).style("top", function(d) {
        return d.rect.y + "px";
      }).style("left", function(d) {
        return d.rect.x + "px";
      }).append("div").attr("class", "article-inner");
      articles.append("a").attr("href", function(d) {
        return d.url;
      }).attr("target", "_blank").append("h2").text(function(d) {
        return d.title;
      }).style("font-size", function(d) {
        if (d.rect.width > 200) {
          return "1.1em";
        } else {
          return "1em";
        }
      }).style("max-height", function(d) {
        if (d.rect.height < this.title_only) {
          return "1.5em";
        } else {
          return "3.0em";
        }
      });
      articles.append("a").attr("href", function(d) {
        return d.url;
      }).attr("target", "_blank").append("div").attr("class", "url").text(function(d) {
        if (d.rect.height < this.title_only) {
          return "";
        } else {
          return d.url;
        }
      });
      images = articles.append("div").attr("class", "image_box").style("max-width", function(d) {
        if (d.rect.width < d.rect.height * 1.6) {
          return "100%";
        } else {
          return "50%";
        }
      }).style("text-align", function(d) {
        if (d.rect.width < d.rect.height * 1.6) {
          return "center";
        } else {
          return "center";
        }
      }).append("img").attr("src", function(d) {
        console.log(d.imageurl);
        return d.imageurl;
      }).style("float", function(d) {
        if (d.rect.width < d.rect.height * 1.6) {
          return "none";
        } else {
          return "left";
        }
      }).style("max-width", function(d) {
        return "100%";
      }).style("max-height", function(d) {
        if (d.rect.width < d.rect.height * 1.6) {
          return "50%";
        } else {
          return "70%";
        }
      });
      content_header_height = 150;
      articles.append("div").attr("class", "content").text(function(d) {
        return d.content;
      });
      return $('img').remove();
    };

    Layout.prototype.loaded = function(is_success) {
      if (is_success) {
        return $('.loading').css('display', 'none');
      } else {
        $('.loading').css('display', 'none');
        return $('.ajax-fail').css('display', 'block');
      }
    };

    Layout.prototype.no_data = function() {
      $('.loading').css('display', 'none');
      return $('.ajax-fail').css('display', 'block');
    };

    return Layout;

  })();

}).call(this);
