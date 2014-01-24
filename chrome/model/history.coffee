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
    )

  clusteringHistories: (array)->
    clustering = new Clustering(array)
    clustering.clustering()
    return clustering

  selectTopHistoryFromEachCluster: (clustering)->
    histories = []
    for i in clustering.clusters.length
      histories[i] = @selectTopHistory(i)
    console.log histories
    return histories


  selectTopHistory: (clusterId)->
    selectTopFromCluster = new SelectTopFromCluster()
    return i


