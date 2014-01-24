// Generated by CoffeeScript 1.6.3
(function() {
  this.History = (function() {
    function History() {}

    History.prototype.changeDate = function(date, searchWord) {
      var end, jsonData, start,
        _this = this;
      if (searchWord == null) {
        searchWord = "";
      }
      start = Date.parse(date) - 86400000;
      end = Date.parse(date);
      jsonData = "";
      return chrome.history.search({
        "text": searchWord,
        "startTime": start,
        "endTime": end,
        "maxResults": 100
      }, function(array) {
        var clustering, histories;
        clustering = _this.clusteringHistories(array);
        return histories = _this.selectTopHistoryFromEachCluster(clustering);
      });
    };

    History.prototype.clusteringHistories = function(array) {
      var clustering;
      clustering = new Clustering(array);
      clustering.clustering();
      return clustering;
    };

    History.prototype.selectTopHistoryFromEachCluster = function(clustering) {
      var histories, i, _i, _len, _ref;
      histories = [];
      _ref = clustering.clusters.length;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        i = _ref[_i];
        histories[i] = this.selectTopHistory(i);
      }
      console.log(histories);
      return histories;
    };

    History.prototype.selectTopHistory = function(clusterId) {
      var selectTopFromCluster;
      selectTopFromCluster = new SelectTopFromCluster();
      return i;
    };

    return History;

  })();

}).call(this);
