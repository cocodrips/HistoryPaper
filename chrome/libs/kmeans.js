// Generated by CoffeeScript 1.6.3
(function() {
  var ClusteringObj;

  ClusteringObj = (function() {
    function ClusteringObj(coordinate, clusterId) {
      this.coordinate = coordinate;
      this.clusterId = clusterId;
    }

    return ClusteringObj;

  })();

  this.Centroid = (function() {
    function Centroid(keys) {
      var k, _i, _len;
      this.num = 0;
      this.coordinate = {};
      for (_i = 0, _len = keys.length; _i < _len; _i++) {
        k = keys[_i];
        this.coordinate[k] = 0;
      }
    }

    return Centroid;

  })();

  this.Kmeans = (function() {
    function Kmeans(coordinates, k) {
      var coordinate, i, _i, _len;
      this.objs = [];
      this.k = k;
      this.objKeys = Object.keys(coordinates[0]);
      this.dim = this.objKeys.length;
      for (i = _i = 0, _len = coordinates.length; _i < _len; i = ++_i) {
        coordinate = coordinates[i];
        this.objs[i] = new ClusteringObj(coordinate, i % k);
      }
    }

    Kmeans.prototype.calcCentroids = function() {
      var c, centroids, obj, _i, _j, _len, _ref, _ref1;
      centroids = [];
      for (c = _i = 0, _ref = this.k; 0 <= _ref ? _i < _ref : _i > _ref; c = 0 <= _ref ? ++_i : --_i) {
        centroids[c] = new Centroid(this.objKeys);
      }
      _ref1 = this.objs;
      for (_j = 0, _len = _ref1.length; _j < _len; _j++) {
        obj = _ref1[_j];
        centroids[obj.clusterId].num++;
        console.log(obj.coordinate);
      }
      return console.log('centroid', centroids);
    };

    return Kmeans;

  })();

}).call(this);
