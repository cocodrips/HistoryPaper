#class @Coordinate
#  constructor: (coordinate, dim)->
##   object {"x":1, "y":2}
#    @coordinate = coordinate
#    @dim = dim
#
#  dist: (coordinate)->
#    sum = 0
#    for k, v of @coordinate
#      sum += Math.pow(@coordinate[k] - coordinate[k], 2)
#    return Math.sqrt(sum/@dim)

class ClusteringObj
  constructor: (@coordinate, @clusterId)->
#    @coordinate = new Coordinate(coordinate, dim)
#    @coordinate = coor
#    @clusterId = i

class @Centroid
  constructor: (keys)->
    @num = 0
    @coordinate = {}
    for k in keys
      @coordinate[k] = 0

class @Kmeans
  constructor: (coordinates, k)->
    @objs = []
    @k = k
    @objKeys = Object.keys(coordinates[0])
    @dim = @objKeys.length
    for coordinate, i in coordinates
      @objs[i] = new ClusteringObj(coordinate, i % k)

  calcCentroids: ()->
    centroids = []

    # initialize
    for c in [0...@k]
      centroids[c] = new Centroid(@objKeys)

    for obj in @objs
      centroids[obj.clusterId].num++
      console.log obj.coordinate
#      for k, v of obj.coordinate.coor
#        console.log k, v
#        centroids[obj.clusterId]['coordinate'][k] += v

#    for c in [0...@k]
#      for k in @objKeys
#        centroids[c][k] /= elementNum[c]

#    console.log 'elementNum', elementNum
    console.log 'centroid', centroids





#
#
#  def calc_centroid(self, cn):
#    self.centroids[cn] = [0]*self.dim
#    n = 0.
#    for i in range(0, len(self.data)):
#    if self.assign[i] == cn:
#    n += 1
#      for j in range(0, self.dim):
#      self.centroids[cn][j] += self.data[i][j]
#    if n > 0:
#    for j in range(0, self.dim):
#      self.centroids[cn][j] /= n
#
#
#  Object.values = function (obj) {
#  var a = [], i = 0;
#  for (var p in obj) if (obj.hasOwnProperty(p)) {
#a[i++] = obj[p];
#  }
#return a;
#  };
#
#



