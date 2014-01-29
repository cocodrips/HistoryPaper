
class @History
  changeDate: (date, searchWord = "")->
    start = Date.parse(date) - 86400000;
    end = Date.parse(date);
    jsonData = ""

    histories = []
    chrome.history.search("text":searchWord, "startTime":start, "endTime":end, "maxResults":100,
      (array)=>
        histories = @clusteringHistories(array)
        layout = new Layout(histories)
        layout.drawArticles()
    )

  clusteringHistories: (array)->

    clustering = new Clustering(array)
    clustering.clusteringHistories()
    @
    return @selectTopHistoryFromEachCluster(clustering)

  selectTopHistoryFromEachCluster: (clustering)->
    selected = []
    selectTopFromCluster = new SelectTopFromCluster()
    for cluster, i in clustering.clusters
      histories = clustering.getClusterHistories(i)
      selected[i] = selectTopFromCluster.getTopHistoryFromHistories(histories)
    return selected



#  selectTopHistory: (clusterHistories)->



