// Generated by CoffeeScript 1.6.3
(function() {
  var CreateData, Hashmap, changeDate;

  $(function() {
    var now;
    now = new Date();
    changeDate(now);
    return $('#date').on('change', function() {
      var date;
      date = $('#date').val();
      console.log(date);
      if (Date.parse(now) > Date.parse(date)) {
        return changeDate(date);
      } else {
        return console.log("We can't analyze your future.");
      }
    });
  });

  changeDate = function(date) {
    var end, jsonData, start,
      _this = this;
    start = Date.parse(date) - 86400000;
    end = Date.parse(date);
    jsonData = "";
    return chrome.history.search({
      "text": "",
      "startTime": start,
      "endTime": end,
      "maxResults": 10
    }, function(array) {
      var cluster;
      cluster = new Cluster(array);
      return cluster.print_title();
    });
  };

  Hashmap = (function() {
    var create_hash;

    function Hashmap(hash) {
      this.hash = create_hash(hash);
      this.hashSortedByTimes = "";
    }

    create_hash = function(array) {
      var e, hash, id, _i, _len;
      hash = [];
      for (_i = 0, _len = array.length; _i < _len; _i++) {
        e = array[_i];
        id = e.id;
        if (!hash[id]) {
          hash[id] = {
            time: e.visitCount,
            url: e.url,
            title: e.title
          };
        }
      }
      return hash;
    };

    Hashmap.prototype.sortedByTimes = function() {
      var sorted,
        _this = this;
      sorted = _.sortBy(this.hash, function(e) {
        return e.time;
      });
      this.hashSortedByTimes = sorted;
      return this.hashSortedByTimes;
    };

    return Hashmap;

  })();

  CreateData = (function() {
    var calcElementNum, canSelectPage, createJson;

    function CreateData(hash) {
      this.urlList = createJson(hash);
      return this.urlList;
    }

    createJson = function(hash) {
      var count, json, urls,
        _this = this;
      count = 0;
      urls = "";
      json = {
        name: "json",
        children: []
      };
      hash.forEach(function(h) {
        var elementNum, url;
        elementNum = calcElementNum();
        console.log(elementNum);
        if (count < elementNum) {
          if (canSelectPage(h)) {
            url = h.url.replace("http://", "") + ",";
            urls += url;
            return count++;
          }
        }
      });
      return urls;
    };

    calcElementNum = function() {
      var height, s, width;
      width = $(window).width();
      height = $(window).height();
      s = width * height;
      if (s < 700000) {
        return 8;
      } else if (s < 1500000) {
        return 10;
      } else {
        return 12;
      }
    };

    canSelectPage = function(h) {
      var domainType, e, exceptions, pageType, t, target, _i, _j, _len, _len1;
      if (!this.domainHash) {
        this.domainHash = [];
      }
      if (h.url.indexOf("https") > -1) {
        return false;
      }
      if (h.url.indexOf("http://") === -1) {
        return false;
      }
      if (h.title.length < 2) {
        return false;
      }
      pageType = h.url.split("/").pop();
      target = ["png", "jpg", "mp3"];
      for (_i = 0, _len = target.length; _i < _len; _i++) {
        t = target[_i];
        if (pageType.indexOf(t) !== -1) {
          return false;
        }
      }
      domainType = h.url.split("/")[2];
      if (!this.domainHash[domainType]) {
        this.domainHash[domainType] = true;
      } else {
        return false;
      }
      exceptions = ["www.youtube.com", "127.0.0.1:5000", "localhost:8080"];
      for (_j = 0, _len1 = exceptions.length; _j < _len1; _j++) {
        e = exceptions[_j];
        if (domainType === e) {
          return false;
        }
      }
      return true;
    };

    return CreateData;

  })();

}).call(this);
