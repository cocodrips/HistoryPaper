// Generated by CoffeeScript 1.6.3
(function() {
  this.start = function() {
    var clusterNum, colors, data, elementNum, i, kmeans, obj, objs, svg, _i;
    clusterNum = 5;
    elementNum = 100;
    data = [];
    for (i = _i = 0; 0 <= elementNum ? _i < elementNum : _i > elementNum; i = 0 <= elementNum ? ++_i : --_i) {
      obj = {};
      obj.x = Math.floor(Math.random() * elementNum);
      obj.y = Math.floor(Math.random() * elementNum);
      data[i] = obj;
    }
    kmeans = new Kmeans(data, clusterNum);
    objs = kmeans.start();
    colors = {
      0: 'pink',
      1: 'red',
      2: 'yellow',
      3: 'blue',
      4: 'green'
    };
    svg = d3.select("body").append("svg").attr("width", 500).attr("height", 500);
    return svg.selectAll("circle").data(objs).enter().append("circle").attr("cx", function(d) {
      console.log(d);
      return d.coordinate['x'] * 3;
    }).attr("cy", function(d) {
      return d.coordinate['y'] * 3;
    }).attr("r", 3).attr("fill", function(d) {
      return colors[d.clusterId];
    });
  };

}).call(this);
