class Centroid
  constructor: (keys)->
    @num = 0
    @coordinate = {}
    for k in keys
      @coordinate[k] = 0

class @Kmeans
  constructor: (objs, k)->
    @objs = objs
    @k = k
    @objKeys = Object.keys(objs[0].coordinate)
    @dim = @objKeys.length

    for obj, i in objs
      obj.clusterId = i % k
      @objs[i] = obj

  start: ()->
    for _ in [0...10]
      centroids = @calcCentroids()
      @updateClusterId(centroids)
    return @objs

  calcCentroids: ()->
    centroids = []
    for c in [0...@k]
      centroids[c] = new Centroid(@objKeys)

    for obj in @objs
      centroids[obj.clusterId].num+=1
      for k, v of obj.coordinate
        centroids[obj.clusterId].coordinate[k] += v

    for c in [0...@k]
      for k in @objKeys
        centroids[c].coordinate[k] /= centroids[c].num

    return centroids

  updateClusterId: (centroids)->
    INF = 100000000000
    for obj in @objs
      min = null
      min_dist = INF
      for c in [0...@k]
        dist = @distance(obj.coordinate, centroids[c].coordinate)
        if dist < min_dist
          min_dist = dist
          min = c

      obj.clusterId = min

  distance: (a, b)->
    sum = 0
    for k of a
      sum += Math.pow(a[k] - b[k], 2)
    return Math.sqrt(sum)
