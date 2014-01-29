describe "SelectTopFromCluster", ->
  beforeEach ->
    @historyobj = []
    for i in [0...10]
      @historyobj[i] = new HistoryObject()
      @historyobj[i].visitCount = 10 - i
      @historyobj[i].url = "http://hoge.com/" + i
    @selectTopFromCluster = new SelectTopFromCluster()


  it "getTopHistoryFromHistories", () ->
    expect(@selectTopFromCluster.getTopHistoryFromHistories(@historyobj).visitCount).toEqual(10)
    expect(@selectTopFromCluster.getTopHistoryFromHistories([])).toEqual('')

