# import
#
#

class @History
  changeDate: (date, searchWord = "")->
    start = Date.parse(date) - 86400000;
    end = Date.parse(date);
    jsonData = ""

    chrome.history.search("text":searchWord, "startTime":start, "endTime":end, "maxResults":100,
      (array)=>
        clustering = @clusteringHistories(array)
        histories = @selectTopHistoryFromEachCluster(clustering)
        console.log histories
    )

  clusteringHistories: (array)->
    clustering = new Clustering(array)
    clusterdHistories = clustering.getClusteredHistories()

    return clustering

  selectTopHistoryFromEachCluster: (clustering)->
    histories = []
    for cluster, i in clustering.clusters
      histories[i] = @selectTopHistory(clustering.getClusterHistories(i))
    return histories


  selectTopHistory: (clusterHistories)->
    for k,v of clusterHistories
      return v


