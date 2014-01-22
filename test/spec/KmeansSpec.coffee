#describe "Coordinate", ->
#  beforeEach ->
#    @target = {"a":1, "b":2}
#    @dim = 2
#    @coordinate = new Coordinate(@target, @dim)
#
#  it "constructor", () ->
#    expect(@coordinate.coordinate).toEqual(@target);
#    expect(@coordinate.dim).toEqual(@dim);
#
#  it "dist", () ->
#    zero = {}
#    for k in Object.keys(@coordinate.coordinate)
#      zero[k] = 0
#    expect(@coordinate.dist(zero)).toEqual(1.5811388300841898) #√5 / 2

describe "Centroid", ->
  beforeEach ->
    keys = ['x', 'y']
    @centroid = new Centroid(keys)

  it "constructor", () ->
    expect(@centroid.num).toEqual(0)
    expect(@centroid.coordinate).toEqual({"x":0,"y":0})

describe "Kmeans", ->
  beforeEach ->
    @data = [{0: 6, 1: 6, 2: 2, 3: 3, 4: 10, 5: 8, 6: 5, 7: 1, 8: 7, 9: 3},
    {0: 2, 1: 7, 2:9, 3: 8, 4: 6, 5: 9, 6: 7, 7: 6, 8: 7, 9: 9},
    {0: 9, 1: 8, 2: 3, 3: 6, 4: 9, 5:5, 6: 7, 7: 4, 8: 3, 9: 7},
    {0: 2, 1: 10, 2: 3, 3: 10, 4: 10, 5: 9, 6: 6, 7: 1, 8: 7, 9: 5},
    {0: 5, 1: 2, 2: 2, 3: 5, 4: 3, 5: 10, 6: 9, 7: 6, 8: 9, 9: 9},
    {0:3, 1: 9, 2: 5, 3: 7, 4: 10, 5: 6, 6: 10, 7: 4, 8: 8, 9: 9},
    {0: 8, 1: 10, 2: 6,3: 10, 4: 7, 5: 3, 6: 5, 7: 7, 8: 4, 9: 10},
    {0: 10, 1: 7, 2: 5, 3: 2, 4: 3, 5:10, 6: 1, 7: 5, 8: 3, 9: 9},
    {0: 7, 1: 10, 2: 3, 3: 3, 4: 9, 5: 6, 6: 1, 7: 6, 8: 10, 9: 3},
    {0: 9, 1: 8, 2: 4, 3: 6, 4: 8, 5: 6, 6: 1, 7: 3, 8: 7, 9: 10}]
    @kmeans = new Kmeans(@data, 3)

  #  afterEach ->

  it "constructor", () ->
    expect(@kmeans.dim).toEqual(10)

  it "calcCentroids", () ->
    console.log @kmeans.calcCentroids()
#    expect(@kmeans.dim).toEqual(10);





#  it "dist", () ->
#    console.log @kmeans.dist(@kmeans.coordinate[0], @kmeans.coordinate[1])
#     expect(@kmeans).toEqual([ 'Jasmine', ' ', 'Spec', ' ', 'Runner', ' ', 'v', '2', '.', '0', '.', '0' ]);
